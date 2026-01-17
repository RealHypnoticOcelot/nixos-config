{ lib, inputs, username, hostname, ... }:

{
  moduleProfiles = {
    sops = {
      system = [
        inputs.sops-nix.nixosModules.sops
        ../modules/sops
      ];
      home-manager = [
        inputs.sops-nix.homeManagerModules.sops
        ../modules/sops/home-manager.nix
      ];
    };
    impermanence = {
      system = [
        inputs.impermanence.nixosModules.impermanence
        ../modules/impermanence
      ];
    };
    stylix = {
      system = [
        inputs.stylix.nixosModules.stylix
        ../modules/stylix
      ];
      home = [
        inputs.stylix.homeModules.stylix
        ../modules/stylix/home-manager.nix
      ];
    };
    ucodenix = {
      system = [
        inputs.ucodenix.nixosModules.default
        ../modules/ucodenix
      ]
    }
  };
}