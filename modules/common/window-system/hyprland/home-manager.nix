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
        "float on, match:class .*" # All windows float, please!
      ];
      bind = [
        "$mod, space, exec, hyprlauncher"
      ];
      binde = [ # Bind something that'll repeat if you hold it
        # xf86bluetooth
        # xf86keyboard
        # xf86tools
        ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # xf86display
        # xf86wlan
        # xf86messenger
        # xf86go
        # cancel
        # xf86favorites
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        "SHIFT, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
        ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
        "SHIFT, xf86audioraisevolume, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
        ", xf86monbrightnessdown, exec, brightnessctl s 5%-"
        ", xf86monbrightnessup, exec, brightnessctl s +5%"
      ];
    };
  };
  xdg.portal = { # For screensharing; not enabling it, just adding the package in case it is enabled
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}