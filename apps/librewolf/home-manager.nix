{ pkgs, userName, lib, config, ... }:

{
  programs.librewolf = {
    enable=true;
    policies = {
      SearchEngines = {
        Add = [
          {
            Name = "Mojeek";
            Description = "Search the web using Mojeek";
            URLTemplate = "https://www.mojeek.com/search?q={searchTerms}&theme=dark&sumt=0&sumb=0";
            Method = "POST";
            IconURL = "https://www.mojeek.com/favicon.png";
          }
          {
            Name = "Startpage";
            Description = "Startpage Search";
            URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}";
            Method = "POST";
            IconURL = "https://www.startpage.com/favicon.ico";
            SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
          }
        ];
        Remove = [
          "DuckDuckGo"
          "Wikipedia (en)"
        ];
        Default = "Mojeek";
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
      };
      DisplayBookmarksToolbar = "never";
    };
    settings = {
      # Librewolf-specific settings
      # "privacy.resistFingerprinting.letterboxing" = true;
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
      "browser.newtabpage.activity-stream.feeds.topsites" = false; # Add shortcuts to new tab
    };
    profiles = {
      "MainProfile" = {
        id = 0;
      };
      "School" = {
        id = 1;
        settings = {
          "browser.toolbars.bookmarks.visibility" = "newtab"; # When to show bookmarks toolbar
        };
      };
    };
  };
}