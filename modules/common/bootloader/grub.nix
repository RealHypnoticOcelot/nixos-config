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
    device = systemDisk;
    useOSProber = true;
  };
}