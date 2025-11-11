{
  lib,
  config,
  inputs,
  username,
  self,
  ...
}:
with lib;
let
  cfg = config.modules.service.quickshell;

  themes = {
    "default" = "${self}/confs/quickshell/default";
  };
in
{
  options.modules.service.quickshell = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable quickshell";
    };

    theme = lib.mkOption {
      type = lib.types.enum (lib.attrNames themes);
      default = "default";
      description = "The QML theme to use for quickshell.";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.quickshell = {
          enable = true;
          systemd = {
            enable = true;
          };

          package = pkgs.symlinkJoin {
            name = "quickshell-with-niri";
            paths = [
              config.programs.niri.package
              inputs.quickshell.packages.${pkgs.system}.default
            ];
            meta.mainProgram = "quickshell";
          };

          activeConfig = cfg.theme;
          configs = themes;
        };
      };
  };
}
