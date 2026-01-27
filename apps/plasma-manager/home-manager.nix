{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = true; # Whether this is the only source of truth for configuration
    workspace.colorScheme = "BreezeDark";
    panels = [
      { # The taskbar at the bottom of the screen
        floating = false;
        widgets = [ # The items on the taskbar
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake-white";
                alphaSort = true;
              };
            };
          }
          {
            name = "org.kde.plasma.icontasks"; # The icons for applications that you pin
            config = {
              General = {
                launchers = [
                  # These are a pain to find! I found them by pinning them manually,
                  # running `nano ~/.config/plasma-org.kde.plasma.desktop-appletsrc`,
                  #. and checking the general applet configuration for 
                  # `org.kde.plasma.icontasks`. Then, you have to change
                  # `file://nix/store/blahblahwhatever/yourapp.desktop` to `applications:yourapp.desktop`.
                  "applications:librewolf.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:steam.desktop"
                  "applications:vesktop.desktop"
                ];
              };
            };
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
          {
            name = "org.kde.plasma.battery";
            config = {
              General = {
                showPercentage = true;
              };
            };
          }
          {
            systemTray.items = {
              # Explicitly show
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
                "org.kde.plasma.brightness"
                "org.kde.kdeconnect"
              ];
              # Explicitly hide
              hidden = [
                #
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "12h";
            };
          }
        ];
      }
    ];
    powerdevil = {
      battery.dimDisplay.idleTimeout = 900; # In seconds
      battery.turnOffDisplay.idleTimeout = 1800; # In seconds
    };
  };
}