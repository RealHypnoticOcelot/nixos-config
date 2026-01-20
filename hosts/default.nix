{
  lib,
  inputs,
  userName,
  hostName,
  systemDisk,
  ...
}:

let
  mkHost = import ./mkhost.nix; #mkHost is the function that generates the system using the profiles and modules we specify
in
{
  p14s-gen6-amd = mkHost {
    stateVersion = "25.11";
    hostPreset = "p14s-gen6-amd"; # MUST be the same as the name of the attribute
    system = "x86_64-linux";
    profiles = [ # Presets for different applications, useful if you need to import multiple modules for one application
      "networking-networkmanager-iwdbackend"
      "fonts"
      "printing"
      "pipewire"
      "sops"
      "stylix"
      "ucodenix"
    ];
    extraModules = [ # Basically just anything you'd need to import that's not a preset
      ../modules/disko/btrfs-subvolumes.nix
    ];
    extraPersist = []; # Extra directories to persist with Impermanence
  };
}