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
    inherit lib inputs userName hostName systemDisk diskFormat;
  }); #mkHost is the function that generates the system using the profiles and modules we specify
in
{
  disko-partition = {
    # Special flake for setting up a brand-new system! Maybe there's a better way to do this, but I don't know it.
    # The issue is that if you try and install from this flake using something like a USB, you'll run out of space.
    # With this, the only thing it does is partition the disk, and then once you can boot into your system, you can set up the rest.
    grub = lib.nixosSystem {
      specialArgs = { inherit hostName systemDisk; };
      modules = [
        ../modules/common/bootloader/grub.nix
        ../modules/disko/${diskFormat}.nix
        /etc/nixos/hardware-configuration.nix
      ];
    };
    systemd-boot = lib.nixosSystem {
      modules = [
        ../modules/common/bootloader/systemd-boot.nix
        ../modules/disko/${diskFormat}.nix
        /etc/nixos/hardware-configuration.nix
      ];
    };
  };
  p14s-gen6-amd = mkHost {
    stateVersion = "25.11";
    hostPreset = "p14s-gen6-amd"; # Determines which hosts/{host} folder you import from
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
    ];
    extraPersist = []; # Extra directories to persist with Impermanence
  };
}