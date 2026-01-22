{ stateVersion, userName, ... }:
{

  users.mutableUsers = lib.mkDefault true; # This gets overridden if you use Impermanence
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "wheel" # Allows for use of sudo
      "video" # Allows for access to video devices(and virtual webcams, like OBS)
    ];
  };

  system.stateVersion = stateVersion;
}