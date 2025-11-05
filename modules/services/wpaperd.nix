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
              duration = "10m";
              transition.colour-distance = { };
            };
          };
        };
      };

    # home-manager.users.${username} = {
    #   home.file."Pictures/Wallpapers" = {
    #     source = ../../wallpapers;
    #     recursive = true;
    #   };
    # };
  };
}
