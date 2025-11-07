{ ... }:
let
  btrfsOptions = [
    "compress=zstd:3"
    "noatime"
  ];
in
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-WDC_WDS500G2B0B-00YS70_20088E808526";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
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
                  type = "lvm_pv";
                  vg = "vg0";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg.vg0 = {
      type = "lvm_vg";
      lvs = {
        "00-swap" = {
          size = "8G";
          content = {
            type = "swap";
          };
        };
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "@root" = {
                mountpoint = "/";
                mountOptions = btrfsOptions;
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = btrfsOptions;
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = btrfsOptions;
              };
              "@var" = {
                mountpoint = "/var";
                mountOptions = btrfsOptions;
              };
              "@log" = {
                mountpoint = "/var/log";
                mountOptions = btrfsOptions;
              };
            };
          };

        };
      };
    };
  };

  # Enable BTRFS and LVM support in the initrd
  boot.initrd.services.lvm.enable = true;
  boot.initrd.kernelModules = [ "btrfs" ];
  boot.supportedFilesystems = [ "btrfs" ];

  #Enable weekly fstrim
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Enable monthly BTRFS scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}
