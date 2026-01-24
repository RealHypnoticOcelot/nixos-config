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
        "match:class .*, float on" # All windows float, please!
        "match:title .*, float on"
      ];
      bind = [
        "$mod, space, exec, hyprlauncher"
      ];
    };
  };
  xdg.portal = { # For screensharing; not enabling it, just adding the package in case it is enabled
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}