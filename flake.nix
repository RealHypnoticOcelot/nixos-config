# The way everything works:
# In flake.nix, you determine your username, hostname, and the disk(as found via lsblk) to be installed on.
# The variables set in flake.nix are passed to ./hosts/default.nix, alongside some useful inputs
# ./hosts/default.nix calls mkHost{}, with different arguments based on what host and variables(username, hostname, and disk) you set.
# mkhost{} is imported by ./mkhost.nix, which itself imports ./moduleprofiles.nix
# ./moduleprofiles.nix is an attribute set, where each attribute houses two lists; a "system" and a "home-manager" list.
# Each list contains the necessary modules in order to install the application, and Home Manager modules if applicable.
# For example, a "discord" attribute would contain a list of system and home-manager modules necessary in order to install Discord onto the device.
# It's not uncommon that a program can be installed and configured just via the system, or just via Home Manager.
# The distinction is that installing via Home Manager installs for the user, whereas installing for the system, well, installs for the system!
# For example, Impermanence affects the whole system, so you wouldn't want to enable that in a Home Manager module.
# mkhost{} parses the attribute set in ./moduleprofiles.nix in order to include any modules specified for your host
# ./mkhost.nix also includes modules specified in extraModules for your host
# ./mkhost.nix also includes modules that are included in any installation, regardless of host
# ./mkhost.nix also includes the configuration.nix and hardware-configuration.nix for your given host, which should reside in hosts/{host}
# hosts/{host}/configuration.nix contains information like timezone and keyboard layout, which may be changed depending on the user.
# I decided to keep those settings there instead of here in flake.nix, because they're not necessary for the system to be set up.
# hosts/{host}/configuration.nix should NOT include settings like desktop environment! These should be configured as modules.
# There's also a hosts/{host}/{host}.nix inside of each folder, which includes necessary settings for proper device functionality.
# For example, the ThinkPad P14s (AMD) Gen 6 has an AMD CPU, which receives microcode updates most effectively via ucodenix, so this file would add that.
# Voila!
#
# I tried very hard to avoid Home Manager at first, as it's an extra layer of complexity, but it eventually became too useful to avoid.
# I took a lot of inspiration from github:dbeley/nixos-config for the way these configs are structured.

{
  description = "Basic System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixos/nixpkgs/nixos-25.11";
    ucodenix.url  "github:e-tho/ucodenix"
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs"; # Instead of installing nixpkgs again(since it's a dependency of this package), just use the one that already exists!
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs"; # Must be repeated, because you can't do "let ... in" with flake inputs
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  # Known as a pattern-matched attribute set, binds { self, nixpkgs, ... } to the "inputs" variable
  # The ... allows for extra inputs to exist even if they're not explicitly in the list(so if I put some other input like inputs.disko, it won't error)
  # Everything explicitly included in the inputs attribute set can be called via its name, like nixpkgs
  # ^ This attribute set only exists within the scope of outputs{} in this flake, and is not available to Nix modules
  # Everything not included in the attribute set (part of the ...) needs to be called via inputs.attribute, like inputs.disko
  # Technically, you could just have { ... }, but that doesn't look as nice(inputs.nixpkgs.lib.nixosSystem compared to nixpkgs.lib.nixosSystem)
  let 
    # Values you should change!
    userName = "hypnoticocelot";
    hostName = "hypnoticocelot-p14s";
    systemDisk = "/dev/nvme0n1";
  in {
    nixosConfigurations = import ./hosts { # Shorthand for ./hosts/default.nix
      inherit nixpkgs inputs; # ./hosts/default.nix will now be able to reference nixpkgs and inputs! Also inputs.disko, inputs.sops, etc.
      inherit userName hostName systemDisk; # Values set prior to setup
      inherit (nixpkgs) lib; # Equal to lib = nixpkgs.lib, and then inheriting lib
    };
  };
}