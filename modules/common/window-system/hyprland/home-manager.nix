{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    systemd.enable = false; # Conflicts with UWSM, according to https://wiki.nixos.org/wiki/Hyprland
    settings = {
      "$mod" = "SUPER";
      # Startup Apps
      exec-once = [];
      windowrule = [
        "float on, class:.*" # All windows float, please!
      ];
      bind = [
        "$mod, space, exec, hyprlauncher"
      ];
      binde = [ # Bind something that'll repeat if you hold it
        # xf86bluetooth
        # xf86keyboard
        # xf86tools
        # xf86audiomicmute
        # xf86display
        # xf86wlan
        # xf86messenger
        # xf86go
        # cancel
        # xf86favorites
        # xf86audiomute
        # xf86audiolowervolume
        # "SHIFT, xf86audiolowervolume
        # xf86audioraisevolume
        # "SHIFT, xf86audioraisevolume
        ", xf86monbrightnessdown, exec, brightnessctl s 5%-"
        ", xf86monbrightnessup, exec, brightnessctl s +5%"
      ];
    };
  };
  xdg.portal = { # For screensharing; not enabling it, just adding the package in case it is enabled
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}