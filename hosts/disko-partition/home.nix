{ stateVersion, userName, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = userName;

    homeDirectory = "/home/${userName}";

    inherit stateVersion;
  };
}