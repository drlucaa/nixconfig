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
      main = {
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
                      mountpoint = "/.swapvol"; 
                      mountOptions = [ "noatime" ];
                      swap = {
                        swapfile = {
                          path = "/swapfile";
                          size = "8G";
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
