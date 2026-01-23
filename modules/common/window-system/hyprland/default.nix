{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Recommended, integrates with systemd
    xwayland.enable = true;
  };
}