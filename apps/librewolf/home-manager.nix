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
      }
    };
    preferences = {
      # Librewolf-specific settings
      "privacy.resistFingerprinting.letterboxing" = true;
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      # Firefox settings
      
    } // lib.optionalAttrs services.desktopManager.plasma6.enable { # If Plasma 6 is enabled, then include these in preferences
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
    profiles = {
      "MainProfile" = {
        
      };
      "School" = {

      };
    };
  };

  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}