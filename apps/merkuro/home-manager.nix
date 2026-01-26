{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.merkuro
  ];
}