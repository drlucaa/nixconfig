{
  pkgs,
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
    programs.mise = {
      enable = true;
      package = pkgs.mise;
      enableFishIntegration = true;
      settings = {
        experimental = true;
      };
      globalConfig = {
        tools = {
        };
      };
    };
  };
}
