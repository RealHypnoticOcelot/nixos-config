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
  # Special flake for setting up a brand-new system! Maybe there's a better way to do this, but I don't know it.
  # The issue is that if you try and install from this flake using something like a USB, you'll run out of space.
  # With this, the only thing it does is partition the disk, and then once you can boot into your system, you can set up the rest.
  disko-partition-grub = lib.nixosSystem {
    specialArgs = { inherit hostName systemDisk; };
    modules = [
      inputs.disko.nixosModules.disko
      ../modules/common/bootloader/grub.nix
      ../modules/disko/${diskFormat}.nix
      ../etc/nixos/hardware-configuration.nix
    ];
  };
  disko-partition-systemd-boot = lib.nixosSystem {
    specialArgs = { inherit hostName systemDisk; };
    modules = [
      inputs.disko.nixosModules.disko
      ../modules/common/bootloader/systemd-boot.nix
      ../modules/disko/${diskFormat}.nix
      ../etc/nixos/hardware-configuration.nix
    ];
  };
  # Normal hosts(follow this )
  p14s-gen6-amd = mkHost {
    stateVersion = "26.05";
    hostPreset = "p14s-gen6-amd"; # Determines which hosts/{host} folder you import from
    profiles = [ # Presets for different applications, see moduleprofiles.nix to see what available profiles and what they import
    # These are imported in order!
      "systemd-boot"
      "disko"
      "sddm"
      "sops"
      "stylix"
      "sddm"
      "plasma-6"
      "plasma-manager"
      "networking-networkmanager"
      "printing"
      "pipewire"
      "brightness"
      "ucodenix"
      "librewolf"
      "vesktop"
      "obs"
      "easyeffects"
      "steam"
      "vscodium"
      "kde-connect"
      "declarative-flatpak"
      "prism-launcher"
      "feishin"
      "vicinae"
      "libreoffice-qt"
      # "kdenlive"
      "merkuro"
      "filelight"
      "wgcf"
      "warp-wireguard"
    ];
    extraModules = []; # Basically just anything you'd need to import that's not a preset
    extraHomeManagerModules = []; # The same, but for Home Manager
    extraPersist = []; # Extra directories to persist with Impermanence
    extraHomeManagerPersist = []; # To be honest, I don't know that this is necessary, but it doesn't hurt to have
  };
}