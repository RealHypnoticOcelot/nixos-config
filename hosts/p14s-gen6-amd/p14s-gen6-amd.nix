{
  config,
  pkgs,
  lib,
  inputs,
  userName,
  hostName,
  stateVersion,
  ...
}:
{
  boot.kernelParams = [
    "microcode.amd_sha_check=off" # Disable microcode checksum verification so that ucodenix can do its thing
  ];
}