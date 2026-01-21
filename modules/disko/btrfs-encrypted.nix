{ hostName, lib, config, ... }:

{
  config = {
    boot.supportedFilesystems = ["btrfs"];
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = { # ESP Partition, for UEFI bootloaders
                priority = 1;
                name = "ESP";
                start = "1M";
                end = "512M"; # A little overkill, but good to be safe!
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = { # The rest of the partition, contains all of the volumes you'll need
                size = "100%";
                content = {
                  type = "luks";
                  name = "root_vg_${hostName}";
                  settings = {
                    allowDiscards = true;
                    # Allows for TRIM requests, where the operating system can communicate with the disk to determine what sectors can be discarded
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/root" = {
                      # /root is the primary volume where the operating system goes!
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd" # Compresses easily compressable files(like text) using the zstd compression algorithm. Minor effect on the CPU, but saves plenty of space.
                          "noatime" # Disables recording the last time a file was accessed
                          "subvol=root" # Mount into the root volume; this one is technically redundant, but the other two aren't. That'll ensure they mount to /persistent instead of /root/persistent, for example.
                        ];
                      };
                      "/persistent" = {
                      # /persistent is a volume specific to Impermanence, and it's where your persistent files go.
                      # Everything in here gets bound to the corresponding location in /root upon boot, and extraneous files get purged.
                      # (If you have Impermanence disabled, this will just be empty, and will not affect anything)
                        mountpoint = "/persistent";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "subvol=persistent"
                        ];
                      };
                      "/nix" = {
                      # /nix stores everything Nix related, like packages, build outputs, all that fancy stuff. It's what allows for rollbacks!
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "subvol=nix"
                        ];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}