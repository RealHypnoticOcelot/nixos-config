{ pkgs, userName, stateVersion, config, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = config.sops.secrets.git_username.path;
        email = config.sops.secrets.git_email.path;
      };
    };
  };

  home = {
    username = userName;

    homeDirectory = "/home/${userName}";

    packages = with pkgs; [
      # Incude any packages you'd like installed for the user!
    ];
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    inherit stateVersion;
  };
}