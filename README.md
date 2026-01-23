# Hypnix

My home-grown NixOS config! I've tried my very best to make the config as modular, maintainable, and expandable as possible.

## Installation:

### 1. Partitioning
If you're installing on a brand-new system, you'll want to partition first! Here's how:

First, run the NixOS minimal installer off of a USB, and select your desired kernel version(You may have to disable Secure Boot).
Then, run the following commands:
```
# Copy config to /tmp/hypnix, and navigate there.
cd /tmp
git clone https://github.com/realhypnoticocelot/hypnix
cd hypnix

# This will generate the hardware-configuration.nix needed for install.
sudo nixos-generate-config --root /tmp/hypnix --no-filesystems

# (If applicable) Modify flake.nix to change userName and hostName, and set systemDisk and diskFormat.
nano flake.nix

# Run the flake! Make sure to choose either grub or systemd-boot, depending on which bootloader you want, and to replace {systemDisk} with the disk you're installing onto.
sudo nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko/latest#disko-install' -- --flake .#disko-partition-{grub|systemd-boot} --disk main {systemDisk} --show-trace
```

You'll have to figure out what exactly to mount to /mnt next. I'd created a LUKS-encrypted BTRFS volume, so I did this:
```
sudo mount -o subvol=root /dev/mapper/root_vg_hypnoticocelot-p14s /mnt
sudo mount -o subvol=persistent /dev/mapper/root_vg_hypnoticocelot-p14s /mnt/persistent
sudo mount -o subvol=nix /dev/mapper/root_vg_hypnoticocelot-p14s /mnt/nix
```
You can find what partition name to use in place of `root_vg_hypnoticocelot-p14s` by running `lsblk` and viewing the partition your LUKS-encrypted volume is on.
**If you're creating an unencrypted disk**, you can just mount the partition directly instead of doing all of this subvolume nonsense. For example:
```
sudo mount /dev/nvme0n1p2 /mnt
```
Once you've mounted your disk, though, you can then run:
```
sudo nixos-enter --root /mnt -c 'passwd'
```
To set a password for the root user. Once that's done, reboot!

### 2. Installing

Once you have a working NixOS system with your desired partition scheme, and you've logged in(presumably as root if you followed the previous set of instructions), you'll want to run these commands:

```
cd /etc/nixos

# Create a shell with the git package available.
nix-shell --extra-experimental-features flakes -p git

# Clone this repository into the current working directory.
git clone https://github.com/realhypnoticocelot/hypnix .
# Build!
sudo nixos-rebuild switch --flake .#{host}
```
Reboot, or it might automatically reboot, and you'll have your fresh new system!

### 3. Post-install

At this point, your main user will not have any password available to it. You'll need to log in as root once more(if you're using a display manager, you'll have to open a TTY for this), and run `passwd {userName}`. Set the password and go back to business!

You'll also want to run `chown -R 1000:1000 /etc/nixos` to have your config's permissions given to the primary user.

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
