{
  lib,
  config,
  pkgs,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.programs.fastfetch;
in
{
  options.modules.programs.fastfetch = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable fastfetch";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.fastfetch = {
        enable = true;
        package = pkgs.fastfetch;
      };
    };
  };
}
