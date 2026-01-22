{
  lib,
  inputs,
  userName,
  hostName,
  systemDisk,
  diskFormat,
  ...
}:

let
  mkHost = (import ./mkhost.nix {
    inherit lib inputs userName hostName systemDisk;
  }); #mkHost is the function that generates the system using the profiles and modules we specify
in
{
  disko-partition = mkHost {
    stateVersion = "25.11";
    hostPreset = "p14s-gen6-amd"; # I'm just going to leave it like this, since it has negligible effect on the partitioning process
    profiles = [ "disko" "systemd-boot" ];
    extraModules = [
      ../modules/disko/${diskFormat}.nix
    ];
  };
  p14s-gen6-amd = mkHost {
    stateVersion = "25.11";
    hostPreset = "p14s-gen6-amd"; # Determines which hosts/{host} folder you import from
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
      ../modules/disko/${diskFormat}.nix # When using Disko, you must import the specific disk layout you selected when partitioning.
    ];
    extraPersist = []; # Extra directories to persist with Impermanence
  };
}