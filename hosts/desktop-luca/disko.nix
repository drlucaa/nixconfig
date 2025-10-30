{ ... }:
let
  btrfs-options = [
    "compress=zstd"
    "noatime"
  ];
in
{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "8G"; # Or your desired swap size
              content = {
                type = "swap";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = btrfs-options;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = btrfs-options;
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = btrfs-options;
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol"; # Temporary mountpoint for creation
                      swap = {
                        swapfile = {
                          # The path is relative to the subvolume root, so this creates /.swapvol/swapfile
                          path = "/swapfile";
                          size = "8G"; # Or your desired swap size
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
  };

  # Enable BTRFS support in the initrd
  boot.initrd.kernelModules = [ "btrfs" ];
  boot.supportedFilesystems = [ "btrfs" ];

  # Enable monthly BTRFS scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}
