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
  wayland.windowManager.hyprland = {
    settings = {
      bindr = [ # Bind something upon key release
        ", xf86audiomicmute, exec, brightnessctl -d 'platform::micmute' s $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 0 || echo 1)"
        # Toggle the microphone LED to match the state of microphone mute
      ];
    };
  };
}