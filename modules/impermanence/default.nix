{
  lib,
  userName,
  ...
}:
{
  users.mutableUsers = lib.mkForce false;
  users.users.${userName}.hashedPasswordFile = "/persistent/passwd_${userName}";
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
      "/var/lib/iwd" # "iNet wireless daemon", daemon to improve connection speeds
      "/var/lib/NetworkManager" # Allows for adding and configuring networks
      "/var/lib/fprint" # Fingerprint readers!
      # /etc is where configuration files live!
      "/etc/nixos" # NixOS configs, like the file you're looking at right now!
      "/etc/ssh" # Where the computer's(not user's) SSH keypairs live, this is necessary to ensure SOPS works as intended
    ];
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
      ];
    };
  };
}