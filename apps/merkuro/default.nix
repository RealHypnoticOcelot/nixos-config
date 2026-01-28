{ pkgs, ... }:

{
  # home.packages = with pkgs; [
  #   kdePackages.merkuro
  #   kdePackages.akonadi
  #   kdePackages.kcontacts
  # ];
  programs.kde-pim = {
    enable = true;
    merkuro = true;
  };
}