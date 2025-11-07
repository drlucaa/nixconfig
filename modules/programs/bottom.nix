{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.bottom;
in
{
  options.modules.programs.bottom = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable bottom";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.bottom = {
          enable = true;
          package = pkgs.bottom;
        };
      };
  };
}
