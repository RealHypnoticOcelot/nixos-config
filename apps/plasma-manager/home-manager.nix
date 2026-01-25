{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = true; # This is the only source of truth for configuration
    panels = { # The taskbar at the bottom of the screen
      floating = "false";
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
                
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
              ]
            }
          };
        }
        {
          name = "org.kde.plasma.marginsseparator"
        }
        {
          systemTray.items = {
            # We explicitly show bluetooth and battery
            shown = [
              "org.kde.plasma.battery"
              "org.kde.plasma.bluetooth"
            ];
            # And explicitly hide networkmanagement and volume
            hidden = [
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.volume"
            ];
          };
        }
        {
          digitalClock = {
            calendar.firstDayOfWeek = "sunday";
            time.format = "12h";
          };
        }
      ]
    };
  };
}