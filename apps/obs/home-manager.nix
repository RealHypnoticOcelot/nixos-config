{ pkgs, lib, config, ... }:

{
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs # Helps with capturing Wayland compositors
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # AMD hardware acceleration
      obs-gstreamer # 
      obs-vkcapture # Vulkan/OpenGL Capture
    ];
  };
}