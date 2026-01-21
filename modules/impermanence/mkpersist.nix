{ lib, inputs, userName, profiles, extraPersist, extraHomeManagerPersist, ... }:

let
  modulePersist = import ./modulepersist.nix;
  modulePersist = lib.flatten (
    map (
      profile:
      lib.optionals (
        modulePersist ? profile && modulePersist.${profile} ? system
      ) modulePersist.${profile}.system
    ) profiles
  );
  homeManagerPersist = lib.flatten (
    map (
      profile:
      lib.optionals (
        modulePersist ? profile && modulePersist.${profile} ? home-manager
      ) modulePersist.${profile}.home-manager
    ) profiles
  );
in
{
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      # /var is where "variable" data is stored: data that's likely to change frequently.
      "/var/log" # System Logs!
      # /var/lib stores non-configuration information for an application or system.
      "/var/lib/bluetooth" # Bluetooth
      "/var/lib/nixos" # NixOS
      "/var/lib/systemd/coredump" # Logs generated upon program crashes
      "/var/lib/fprint" # Fingerprint readers!
      # /etc is where configuration files live!
      "/etc/nixos" # NixOS configs, like the file you're looking at right now!
    ]
    ++ modulePersist
    ++ extraPersist;
    files = [
      "/etc/machine-id" # A unique device ID generated upon first boot, useful for identifying devices even after hardware changes
    ];
    users.${userName} = {
      directories = [
        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        "Music"
      ]
      ++ homeManagerPersist
      ++ extraHomeManagerPersist;
    };
  };
  users.mutableUsers = lib.mkForce false;
  users.users.${userName}.hashedPasswordFile = "/persistent/passwd_${userName}";

  fileSystems = {
    "/persistent".neededForBoot = true;
    "/nix".neededForBoot = true;
  };

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/mapper/root_vg_${hostName} /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/persistent/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/persistent/old_roots/$timestamp/"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/persistent/old_roots/ -mindepth 1 -maxdepth 1 -mtime +1); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}