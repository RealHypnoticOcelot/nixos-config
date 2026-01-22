{
  config,
  pkgs,
  lib,
  systemDisk,
  ...
}:

{
  boot.loader.grub = {
    enable = true;
    device = systemDisk;
  };
}