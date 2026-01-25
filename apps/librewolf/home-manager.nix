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
            URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}&prfe=d05529b22695d9b21ff0bfe3d59b0435c473b251863471092ba162b9a294373c050a20e9412164b63e1334d4b1fc2d4580f9085c3c08441b6809c72c78d039363453dbf0f832bdceebc83f234de3";
            # REALLY long, but this contains user preferences! Now, when we search, theme and everything will always be set by default.
            Method = "POST";
            IconURL = "https://www.startpage.com/favicon.ico";
            SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
          }
        ];
        Remove = [
          "DuckDuckGo"
          "Wikipedia (en)"
        ];
        Default = "Startpage";
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = { # uBlock Origin
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # Bitwarden
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = { # Terms of Service; Didn't Read
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/terms-of-service-didnt-read/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };
        "plasma-browser-integration@kde.org" = { # Plasma Browser Integration
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        }
      };
      DisplayBookmarksToolbar = "never";
    };
    settings = {
      # Librewolf-specific settings
      "privacy.resistFingerprinting.letterboxing" = true;
      "webgl.disabled" = false;
      "privacy.sanitize.sanitizeOnShutdown" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "identity.fxaccounts.enabled" = true; # Enable Firefox Sync
      # Firefox settings
      "browser.theme.content-theme" = 0; # Dark theme!
      "media.eme.enabled" = true; # Encrypted Media Extensions, or DRM-protected media
      "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false; # "Support LibreWolf" checkbox
      "privacy.userContext.enabled" = false; # Container Tabs
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.quickactions" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.search.separatePrivateDefault" = false; # Whether to use a different search engine for private search
      "browser.tabs.loadinBackground" = false; # Set FALSE to switch to newly-opened links, and TRUE to not
    } // lib.optionalAttrs (config.programs.desktopManager.enable or false) { # If Plasma 6 is enabled, then include these in preferences
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
}