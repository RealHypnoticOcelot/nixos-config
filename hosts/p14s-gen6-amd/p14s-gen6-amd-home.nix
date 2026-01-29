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
      # Keyboard-specific functions, so they go here!
      binde = [ # Bind something that'll repeat if you hold it
        # xf86bluetooth
        # xf86keyboard
        # xf86tools
        ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && brightnessctl -d 'platform::micmute' s $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0)" # Also toggles the LED to match the mute state
        # xf86display
        # xf86wlan
        # xf86messenger
        # xf86go
        # cancel
        # xf86favorites
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && brightnessctl -d 'platform::mute' s $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)"
        ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        "SHIFT, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
        ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
        "SHIFT, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
        ", xf86monbrightnessdown, exec, brightnessctl s 5%-"
        ", xf86monbrightnessup, exec, brightnessctl s +5%"
      ];
    };
  };
  programs.plasma = {
    hotkeys.commands."mute-microphone" = {
      name = "Mute Microphone patch for P14S";
      key = "Mute Microphone";
      command = "\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && brightnessctl -d 'platform::micmute' s \\$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0)\"";
      # Funny business with escaping
    };
    configFile = {
      "services/plasma-manager-commands.desktop".mute-microphone = "Microphone Mute";
    }
  };
  programs.git = {
    settings = {
      user = {
        name = "HypnoticOcelot";
        email = "57046530+RealHypnoticOcelot@users.noreply.github.com";
      };
    };
  };
}