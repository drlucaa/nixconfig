{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.jjui;
in
{
  options.modules.programs.jjui = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable jjui";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.jjui = {
          enable = true;
          package = pkgs.unstable.jjui;
        };
      };
  };
}
