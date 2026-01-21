{
  config,
  pkgs,
  lib,
  inputs,
  userName,
  hostName,
  ...
}:

{
  users.users.${userName} = {
    extraGroups = [
      "networkmanager" # Allows for network configuration
    ];
  };

  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd"; # A modern replacement for the alternative, wpa_supplicant
    };
    wireless.iwd.settings = {
      Settings = {
        AddressRandomization = network;
        # "network" randomizes the MAC Address upon each connection to a network. See iwd.config(5) for more details
      };
    };
  };
}