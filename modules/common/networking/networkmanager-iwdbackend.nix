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
      wifi.backend = "wpa_supplicant"; # iwd is a modern replacement for the alternative, wpa_supplicant
      # NetworkManager cannot auto-generate provisioning files for 802.1x connections when using iwd as a backend.
      # See https://wiki.gentoo.org/wiki/NetworkManager#Failed_to_add_new_connection:_802.1x_connections_must_have_IWD_provisioning_files
      # For more information.
    };
    wireless.iwd.settings = {
      Settings = {
        AddressRandomization = "network";
        # "network" randomizes the MAC Address upon each connection to a network. See iwd.config(5) for more details
      };
    };
  };
}