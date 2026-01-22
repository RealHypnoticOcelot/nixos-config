{
  lib,
  inputs,
  userName,
  hostName,
  systemDisk,
  ...
}:

let
  mkHost = (import ./mkhost.nix {
    inherit lib inputs userName hostName systemDisk;
  }); #mkHost is the function that generates the system using the profiles and modules we specify
in
{
  p14s-gen6-amd = mkHost {
    stateVersion = "25.11";
    hostPreset = "p14s-gen6-amd"; # MUST be the same as the name of the attribute
    system = "x86_64-linux";
    profiles = [ # Presets for different applications, useful if you need to import multiple modules for one application
      "systemd-boot"
      "disko"
      "impermanence"
      "networking-networkmanager-iwdbackend"
      "printing"
      "pipewire"
      "sops"
      "stylix"
      "ucodenix"
      "librewolf"
      "vesktop"
    ];
    extraModules = [ # Basically just anything you'd need to import that's not a preset
      ../modules/disko/btrfs-encrypted.nix # When using Disko, you must import the specific disk layout you want.
    ];
    extraPersist = []; # Extra directories to persist with Impermanence
  };
}