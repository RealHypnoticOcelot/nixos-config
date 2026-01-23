{
  services.hyprlock = {
    enable = true;
  };
  security.pam.services.hyprlock = {}; # Disables Hyprlock security with Linux's Pluggable Authentication Modules
}