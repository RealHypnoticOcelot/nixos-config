{ pkgs, nixosConfig, ... }:

{
  home.packages = with pkgs; [
    kdePackages.merkuro
  ]
  ++ lib.optionals nixosConfig.services.desktopManager.plasma6.enable [
    # Packages needed for the Contacts widget on Plasma 6 to work properly
    kdePackages.kcontacts
    kdePackages.akonadi-contacts
    # Package for better integration into Plasma(like adding Merkuro calendars to the Digital Clock widget)
    # Technically, this package includes the former two packages, but I'm separating them anyways because
    # I want to document which packages are necessary for the Contacts widget specifically
    # Also, this latter package includes a lot of other stuff not particularly relevant to Merkuro
    kdePackages.kdepim-addons
  ];
}