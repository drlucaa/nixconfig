{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.displayManager.ly;
in
{
  options.modules.displayManager.ly = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the Ly display manager";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      package = pkgs.ly;
      settings = {
        bigclock = true;
      };
    };
  };
}
