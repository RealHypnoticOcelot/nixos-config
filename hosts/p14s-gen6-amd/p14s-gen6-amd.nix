{
  config,
  pkgs,
  lib,
  inputs,
  userName,
  hostName,
  stateVersion,
  ...
}:
{
  boot.kernelParams = [
    "microcode.amd_sha_check=off" # Disable microcode checksum verification so that ucodenix can do its thing
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
  ];
  systemd.services.alsaMicrophone = { # Creates systemd service that disables Auto-Mute Mode on the microphone on sound card 1, automatically on boot
    enable = true;
    script = ''
      amixer -c 1 set "Auto-Mute Mode" Disabled
    '';
    wantedBy = [ "multi-user.target" ];
  };
}