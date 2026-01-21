{ lib, inputs, userName, hostName, systemDisk, ... }:

let
  moduleProfiles = (import ./moduleprofiles.nix {
    inherit inputs systemDisk;
  });
in
{ # The arguments that mkHost supports go below this line
  stateVersion,
  hostPreset,
  system ? "x86_64-linux",
  profiles ? [ ],
  extraModules ? [ ],
  extraHomeManagerModules ? [ ],
  extraPersist ? [ ],
  extraHomeManagerPersist ? [ ],
}:
let
  systemModules = lib.flatten (
    map (
      profile:
      lib.optionals (
        moduleProfiles ? ${profile} && moduleProfiles.${profile} ? "system"
        # Checks if profile exists within moduleProfiles, then checks if moduleProfiles.{$profile}
        # is valid, then checks if moduleProfiles.${profile} has a "system" attribute
      ) moduleProfiles.${profile}.system
      # If conditions are met, return moduleProfiles.{$profile}.system
    ) profiles # The function isn't mapping TO profiles, it's mapping FROM profiles
  );
  # The exact same as above, I'm not sure if there's any more efficient way to do this
  homeManagerModules = lib.flatten (
    map (
      profile:
      lib.optionals (
        moduleProfiles ? ${profile} && moduleProfiles.${profile} ? "home-manager"
      ) moduleProfiles.${profile}.home-manager
    ) profiles
  );
in
lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit
      userName
      hostName
      systemDisk
      inputs
      stateVersion
      ;
  }; # By inheriting something into specialArgs, you make that value able to be referenced globally by ANY system module!
  modules = [ # These are modules that are included in any installation, regardless of host!
    ( import ./${hostPreset}/configuration.nix )
    ( import ./${hostPreset}/hardware-configuration.nix )
    ( import ./${hostPreset}/${hostPreset}.nix )
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            userName
            hostName
            systemDisk
            system
            inputs
            stateVersion
            ;
          selectedProfiles = profiles;
        };
        # Anything inherited into extraSpecialArgs becomes available to ANY home-manager module(that is to say, any module imported by home-manager)!
        users.${userName} = {
          # Modules imported under here are under the USER SPACE!
          # This is the key distinction between importing here and importing modules normally.
          # If you enable a program, for instance, it'll be enabled for that user instead of system-wide.
          imports = [
            ( import ./${hostPreset}/home.nix )
            ( import ./${hostPreset}/${hostPreset}-home.nix )
          ]
          ++ homeManagerModules
          ++ extraHomeManagerModules;
        };
      };
    }
  ]
  ++ systemModules
  ++ extraModules
  ++ (if profiles ? "impermanence" then [ # If impermanence is one of the profiles, import the module that handles it specially
    (import ../modules/impermanence/mkpersist.nix {
      inherit inputs profiles extraPersist extraHomeManagerPersist;
    })
  ] else []);
  # Also import anything from these lists
}