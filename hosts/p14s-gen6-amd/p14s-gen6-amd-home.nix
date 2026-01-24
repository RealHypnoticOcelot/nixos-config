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
      binde = [ # Bind something that'll repeat if you hold it
        ", xf86audiomicmute, exec, brightnessctl -d 'platform::micmute' s $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 0 || echo 1)"
        # Toggle the microphone LED to match the state of microphone mute
      ];
    };
  };
}