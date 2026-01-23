{ pkgs, config, lib, ... }:

{
  # This is a system module so that we can do things like open ports for things like remote play.
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg
  ];
}