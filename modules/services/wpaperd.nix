{
  lib,
  config,
  inputs,
  username,
  ...
}:
let
  cfg = config.modules.wallpaperDaemon.wpaperd;
in
{
  options.modules.wallpaperDaemon.wpaperd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the wpaperd wallpaper daemon";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        services.wpaperd = {
          enable = true;
          package = pkgs.wpaperd;
          settings = {
            default = {
              path = "${inputs.self}/wallpapers";
              initial-transition = false;
              duration = "1h";
              transition.colour-distance = { };
            };
          };
        };
      };
  };
}
