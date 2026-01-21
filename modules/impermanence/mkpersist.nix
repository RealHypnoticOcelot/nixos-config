{ lib, inputs, userName, ... }:

let
  modulePersist = import ./modulepersist.nix;
in
{
  profiles ? [ ],
  extraPersist ? [ ],
  extraHomeManagerPersist ? [ ],
}:
let
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
}