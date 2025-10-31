{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options.modules.virtualisation = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    virt-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    waydroid.enable = lib.mkEnableOption "Enable Waydroid";
  };

  config = lib.mkIf (config.modules.virtualisation.enable) {
    virtualisation.libvirtd.enable = true;
    virtualisation.waydroid.enable = config.modules.virtualisation.waydroid.enable;

    virtualisation.vmVariant.virtualisation = {
      qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];

      memorySize = 16384;
      cores = 4;
    };

    programs.virt-manager.enable = config.modules.virtualisation.virt-manager.enable;
    programs.dconf.enable = true;

    environment.systemPackages = lib.mkIf (config.modules.virtualisation.waydroid.enable) [
      pkgs.waydroid-helper
    ];

    users.users.${username} = {
      extraGroups = [
        "libvirtd"
        "kvm"
      ];
    };

    home-manager.users.${username} =
      { config, ... }:
      {
        dconf.settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" ];
          };
        };
      };
  };
}
