{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.tools;
in
{
  options.modules.programs.tools = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tools";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.unstable.yatto
        ];

        xdg.configFile = {
          "yatto/config.toml".source = ../../confs/yatto/config.toml;
        };
      };
  };
}
