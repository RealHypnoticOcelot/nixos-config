{
  programs.librewolf = {
    policies = {
      ExtensionSettings = {
        "plasma-browser-integration@kde.org" = { # Plasma Browser Integration
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
    };
    settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
    nativeMessagingHosts = [
      kdePackages.plasma-browser-integration # Make the plasma browser integration package available to extensions
    ];
  };
}