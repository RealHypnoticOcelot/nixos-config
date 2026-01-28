{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    kdePackages.merkuro
  ]
  ++ lib.optionals config.services.desktopManager.plasma6.enable [ # Packages needed for the Contacts widget on Plasma 6 to work properly
    kdePackages.kcontacts
    kdePackages.akonadi-contacts
  ];
}