{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ucodenix.url = "github:e-tho/ucodenix";
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