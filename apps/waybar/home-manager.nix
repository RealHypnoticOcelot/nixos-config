{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  security.pam.services.hyprlock = {}; # Disables Hyprlock security with Linux's Pluggable Authentication Modules
}