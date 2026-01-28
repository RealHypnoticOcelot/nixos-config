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
  networking-networkmanager = {
    system = [
      ../modules/common/networking/networkmanager.nix
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
    default = [
      ../apps/easyeffects
    ];
    home-manager = [
      ../apps/easyeffects/home-manager.nix
    ];
  };
  obs = {
    home-manager = [
      ../apps/obs/home-manager.nix
    ];
  };
  plasma-6 = {
    system = [
      ../modules/common/window-system/plasma-6
    ];
    home-manager = [
      ../modules/common/window-system/plasma-6/home-manager.nix
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
  kitty = {
    home-manager = [
      ../apps/kitty/home-manager.nix
    ];
  };
  sddm = {
    system = [
      ../modules/common/window-system/display-manager/sddm.nix
    ];
  };
  brightness = {
    home-manager = [
      ../modules/common/brightness.nix
    ];
  };
  xdg-desktop-portal = {
    system = [
      ../modules/common/xdg-desktop-portal.nix
    ];
  };
  mako = {
    home-manager = [
      ../apps/mako/home-manager.nix
    ];
  };
  hyprpolkitagent = {
    home-manager = [
      ../apps/hyprpolkitagent/home-manager.nix
    ];
  };
  hypridle = {
    home-manager = [
      ../apps/hypridle/home-manager.nix
    ];
  };
  regreet = {
    system = [
      ../modules/common/window-system/display-manager/regreet.nix
    ];
  };
  hyprlauncher = {
    home-manager = [
      ../apps/hyprlauncher/home-manager.nix
    ];
  };
  hyprlock = {
    system = [
      ../apps/hyprlock
    ];
    home-manager = [
      ../apps/hyprlock/home-manager.nix
    ];
  };
  copyq = {
    home-manager = [
      ../apps/copyq/home-manager.nix
    ];
  };
  waybar = {
    home-manager = [
      ../apps/waybar/home-manager.nix
    ];
  };
  dolphin = {
    system = [
      ../apps/dolphin
    ];
  };
  kde-connect = {
    system = [
      ../apps/kde-connect
    ];
    home-manager = [
      ../apps/kde-connect/home-manager.nix
    ];
  };
  vscodium = {
    home-manager = [
      ../apps/vscodium/home-manager.nix
    ];
  };
  plasma-manager = {
    home-manager = [
      inputs.plasma-manager.homeModules.plasma-manager
      ../apps/plasma-manager/home-manager.nix
    ];
  };
  declarative-flatpak = {
    system = [
      ../apps/declarative-flatpak
    ];
    home-manager = [
      inputs.flatpaks.homeModules.default
      ../apps/declarative-flatpak/home-manager.nix
    ];
  };
  feishin = {
    home-manager = [
      ../apps/feishin/home-manager.nix
    ];
  };
  vicinae = {
    home-manager = [
      ../apps/vicinae/home-manager.nix
    ];
  };
  prism-launcher = {
    home-manager = [
      ../apps/prism-launcher/home-manager.nix
    ];
  };
  libreoffice-qt = {
    home-manager = [
      ../apps/libreoffice-qt/home-manager.nix
    ];
  };
  kdenlive = {
    home-manager = [
      ../apps/kdenlive/home-manager.nix
    ];
  };
  filelight = {
    home-manager = [
      ../apps/filelight/home-manager.nix
    ];
  };
  merkuro = {
    system = [
      ../apps/merkuro
    ];
  };
  thunderbird = {
    home-manager = [
      ../apps/thunderbird/home-manager.nix
    ];
  };
  wgcf = {
    home-manager = [
      ../apps/wgcf/home-manager.nix
    ];
  };
  warp-wireguard = {
    system = [
      ../modules/common/networking/warp-wireguard.nix
    ];
  };
  warp-cli = {
    home-manager = [
      ../apps/warp-cli/home-manager.nix
    ];
  };
}