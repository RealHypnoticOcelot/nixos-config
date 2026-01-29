{ ... }:

{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
    };
  };
  programs.plasma = {
    hotkeys.commands."vicinae" = {
      name = "Vicinae";
      key = "Ctrl+Space";
      command = "vicinae toggle";
    };
    configFile = {
      "services/plasma-manager-commands.desktop".vicinae = "Ctrl+Space";
    };
  };
}