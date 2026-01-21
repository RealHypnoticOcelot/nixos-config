{ lib, inputs, userName, hostName, systemDisk, ... }:

{
  moduleProfiles = {
    sops = {
      system = [
        inputs.sops-nix.nixosModules.sops
        ../modules/sops
      ];
      home-manager = [
        inputs.sops-nix.homeManagerModules.sops
        ../modules/sops/home-manager.nix
      ];
    };
    disko = {
      system = [
        inputs.disko.nixosModules.disko
        { inputs.disko.devices.disk.main.device = systemDisk; }
      ];
    };
    impermanence = {
      # This is handled specially in mkHost{}
      system = [
        inputs.impermanence.nixosModules.impermanence
      ];
    };
    stylix = {
      system = [
        inputs.stylix.nixosModules.stylix
        ../modules/stylix
      ];
      home-manager = [
        inputs.stylix.homeModules.stylix
        ../modules/stylix/home-manager.nix
      ];
    };
    ucodenix = {
      system = [
        inputs.ucodenix.nixosModules.default
        ../modules/ucodenix
      ];
    };
    librewolf = {
      home-manager = [
        ../apps/librewolf/home-manager.nix
      ];
    };
    vesktop = {
      home-manager = [
        ../apps/vesktop/home-manager.nix
      ];
    };
    printing = {
      system = [
        ../modules/common/printing.nix
      ];
    };
    networking-networkmanager-iwdbackend = {
      system = [
        ../modules/common/networking/networkmanager-iwdbackend.nix
      ];
    };
    pipewire = {
      system = [
        ../modules/common/pipewire.nix
      ];
    };
    grub = {
      system = [
        ../modules/commmon/bootloader/grub.nix
      ];
    };
    systemd-boot = {
      system = [
        ../modules/commmon/bootloader/systemd-boot.nix
      ];
    };
  };
}