{ pkgs, userName, lib, config, ... }:

{
  programs.librewolf = {
    enable=true;
    policies = {
      SearchEngines = {
        Add = [
          {
            Name = "Startpage";
            Description = "Startpage Search";
            URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}";
            Method = "GET";
            IconURL = "https://www.startpage.com/favicon.ico";
            SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
          }
        ];
        Default = "Startpage";
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = { # uBlock Origin
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # Bitwarden
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = { # Terms of Service; Didn't Read
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/terms-of-service-didnt-read/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
    };
    settings = {
      # Librewolf-specific settings
      "privacy.resistFingerprinting.letterboxing" = true;
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      # Firefox settings
      "browser.theme.content-theme" = 0; # Dark theme!
      "media.eme.enabled" = true; # Encrypted Media Extensions, or DRM-protected media
    } // lib.optionalAttrs (config.programs.plasma6.enable or false) { # If Plasma 6 is enabled, then include these in preferences
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
    profiles = {
      "MainProfile" = {
        id = 0;
      };
      "School" = {
        id = 1;
      };
    };
  };

  stylix.targets.librewolf.profileNames = [ "MainProfile" "School" ];
}