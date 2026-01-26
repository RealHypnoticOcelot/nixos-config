{ userName, ... }:

{
  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      "flathub:app/org.vinegarhq.Sober//stable"
    ];
  };
  programs.xdg = {
    enable = true;
    systemDirs.data = [
      "~/.local/share/flatpak/exports/share"
    ];
  };
}