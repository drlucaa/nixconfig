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
    enable = lib.mkEnableOption "Enable the swww wallpaper daemon";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home-manager.users.${username} = {
      home.file."Pictures/Wallpapers" = {
        source = ../../wallpapers;
        recursive = true;
      };
    };
  };
}
