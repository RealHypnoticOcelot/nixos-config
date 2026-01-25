{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = true; # Whether this is the only source of truth for configuration
    workspace.colorScheme = "BreezeDark";
    panels = { # The taskbar at the bottom of the screen
      widgets = [ # The items on the taskbar
        {
          floating = false;
        }
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
              ];
            };
          };
        }
        {
          name = "org.kde.plasma.marginsseparator";
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
      ];
    };
  };
}