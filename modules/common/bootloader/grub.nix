{
  config,
  pkgs,
  lib,
  inputs,
  userName,
  systemDisk,
  ...
}:

{
  boot.loader.grub = {
    enable = true;
    device = systemDisk;
  };
}