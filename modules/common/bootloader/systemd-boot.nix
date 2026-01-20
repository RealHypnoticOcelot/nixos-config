{
  config,
  pkgs,
  lib,
  inputs,
  userName,
  hostName,
  systemDisk,
  ...
}:

{
  boot.loader.systemd-boot = {
    enable = true;
    efi.canTouchEfiVariables = true;
  }
}