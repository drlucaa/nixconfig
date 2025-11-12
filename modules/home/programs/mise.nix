{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.mise;
in
{
  options.modules.programs.mise = {
    enable = lib.mkEnableOption "Enable mise";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.mise = {
          enable = true;
          package = pkgs.unstable.mise;
          enableFishIntegration = true;
          settings = {
            experimental = true;
          };
          globalConfig = {
            tools = {
              go = "1.25";
              helm = "3.19";
              node = "lts";
              pnpm = "10.20";
            };
          };
        };
      };
  };
}
