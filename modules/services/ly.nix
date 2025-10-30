{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.displayManager.ly;
in {
  options.modules.displayManager.ly = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the Ly display manager";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      package = pkgs.ly;
      settings = {
        bigclock = true;
      };
    };
  };
}
