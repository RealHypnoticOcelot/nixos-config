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
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure console keymap
  console.keyMap = "us";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.mutableUsers = lib.mkDefault true; # This gets overridden if you use Impermanence
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "wheel" # Allows for use of sudo
      "video" # Allows for access to video devices(and virtual webcams, like OBS)
    ];
  };

  hardware.graphics = {
    enable32Bit = true; # Install 32-bit drivers for applications like Wine
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans # Chinese, Japanese, and Korean fonts
      noto-fonts-color-emoji
      liberation_ttf
    ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.command-not-found.enable = false; # If you run a command and it's not available, show what packages will provide that command. Requires nix-channels, though, which you don't have if you have flakes
  services.fstrim.enable = true; # Tells SSDs when data is no longer in use, so that it can be erased and marked as free
  zramSwap.enable = false; # Increases RAM availability at the cost of computational power

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ]; # Enable flakes!
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = stateVersion; # Did you read the comment?
}