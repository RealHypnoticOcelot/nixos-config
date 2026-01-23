{ lib, inputs, diskFormat, ... }:

{
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
      ../modules/disko/${diskFormat}.nix
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
      ../modules/common/bootloader/grub.nix
    ];
  };
  systemd-boot = {
    system = [
      ../modules/common/bootloader/systemd-boot.nix
    ];
  };
  steam = {
    system = [
      ../apps/steam
    ];
  };
  easyeffects = {
    home-manager = [
      ../apps/easyeffects/home-manager.nix
    ];
  };
  obs = {
    home-manager = [
      ../apps/obs
    ];
  };
  plasma-6 = {
    system = [
      ../modules/common/window-system/plasma-6
    ];
  };
  hyprland = {
    system = [
      ../modules/common/window-system/hyprland
    ];
    home-manager = [
      ../modules/common/window-system/hyprland/home-manager.nix
    ];
  };
}