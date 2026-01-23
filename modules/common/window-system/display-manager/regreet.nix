{
  services.xserver.enable = true; # X server! Not sure if it's needed here, but it sure can't hurt.
  services.greetd = {
    enable = true;
  };
  programs.regreet = {
    enable = true;
  };
}