# Hypnix

My home-grown NixOS config! I've tried my very best to make the config as modular, maintainable, and expandable as possible.

## How everything works:

- In `flake.nix`, you determine your username, hostname, and the disk to be installed on(which you can determine via `lsblk`).
- When you build the system, you run `sudo nixos-rebuild switch --flake .#{host}`.
- `{host}` can be any attribute that exists within `./hosts/default.nix`, like `p14s-gen6-amd`.
- `flake.nix` passes the variables you selected to `./hosts/default.nix`, alongside some useful inputs.
- Depending on what `{host}` you have, `./hosts/default.nix` will call the function `mkHost{}` with different arguments.
- `mkHost{}` is imported by `./hosts/mkhost.nix`, and itself imports `./hosts/moduleprofiles.nix`.
- `moduleprofiles.nix` is an attribute set, where each attribute houses up to two lists; a `system` and a `home-manager` list.
- Each list contains a set of modules to import in order to install your application of choice.
- The difference between the `system` list and `home-manager` list is scope. `home-manager` modules will be imported for the user, and not the system as a whole.
- For example, a `home-manager` install of Firefox will install Firefox for just the user, and not the entire system.
- Conversely, a `system` install of sops-nix will install sops-nix for the entire system, and not just the user.
- Sometimes, an application will install something both for the system and for the user. In this case, all modules will be imported.
- For example, Stylix is installed system-wide for access to system-level programs like bootloaders and display managers.
- Stylix is also installed user-wide so that applications can be styled for a single user instead of for the entire system.
- So, `mkHost{}` will parse the profiles passed by `./hosts/default.nix`, and include any that also exist in `moduleprofiles.nix`.
- `mkHost{}` also includes modules specified by `extraModules` for your host.
- `mkHost{}` also includes pre-determined modules that are included in any installation, regardless of host.
- `mkHost{}` also includes the `configuration.nix` and `hardware-configuration.nix` for your given host, which must reside in `hosts/{host}`.
- `./hosts/{host}/configuration.nix` contains information like timezone and keyboard layout, which may be changed depending on the user.
- Common modules, such as printing and networking functionality, are handled in `./modules/common/`.
- There's also a `{host}.nix` inside of each `./hosts/{host}` folder, which includes necessary settings for proper device functionality.
- Similarly, there's a `{host}-home.nix`, which is the same thing but for Home Manager.
- For example, the ThinkPad P14s (AMD) Gen 6 has speakers that sound poor by default, unless improved via some EasyEffects presets. The `p14s-gen6-amd-home.nix` file would include a preset for EasyEffects that helps with the speakers.


### Special Impermanence Handling
- Special handling is included for Impermanence! If Impermanence is an enabled profile, the list of profiles will be passed by `mkHost{}` to `mkPersist{}`.
- `mkPersist{}` exists in `./modules/impermanence/mkpersist.nix`. It will itself import `./modules/impermanence/modulepersist.nix`.
`modulepersist.nix` is an attribute set structurally identical to `moduleprofiles.nix`. The difference is that instead of each list containing a set of modules to import, it contains a set of directories to persist with Impermanence.
- So, `mkPersist{}` will parse the profiles it's passed, and include any corresponding paths in `modulepersist.nix`.
- `mkPersist{}` also includes directories specified by `extraPersist` for your host.
- `mkPersist{}` also includes pre-determined directories to persist for any installation with Impermanence, regardless of host.
- `mkPersist{}` also disables mutable users, and sets the location of your user's hashed password file to a persistent location.

I tried very hard to avoid Home Manager at first, as it's an extra layer of complexity, but it eventually became too useful to avoid.

If you see any glaring problems, please open an issue!

Big thanks to [dbeley](https://dbeley.ovh/en/) for providing inspiration on how to properly structure this repo!