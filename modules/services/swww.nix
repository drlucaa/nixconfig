{
  lib,
  config,
  pkgs,
  inputs,
  username,
  ...
}:
let
  cfg = config.modules.wallpaperDaemon.swww;
in
{
  options.modules.wallpaperDaemon.swww = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the swww wallpaper daemon";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.swww.packages.${pkgs.system}.default
    ];

    home-manager.users.${username} = {
      home.file."Pictures/Wallpapers" = {
        source = ../../wallpapers;
        recursive = true;
      };
    };
  };
}
