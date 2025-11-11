{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.bat;
in
{
  options.modules.programs.bat = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable bat";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.bat = {
          enable = true;
          package = pkgs.bat;
        };

        programs.fish.shellAliases = {
          cat = "bat";
        };
      };
  };
}
