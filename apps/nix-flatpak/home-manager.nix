{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      {
        appId = "org.vinegarhq.Sober";
        origin = "flathub";
      }
    ];
  };
  xdg.systemDirs.data = [ "$HOME/.local/share/flatpak/exports/share" ]; # Makes desktop icons available for installed apps, see https://github.com/gmodena/nix-flatpak/discussions/187
}