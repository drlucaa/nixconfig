{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.desktop.ly;
in {
  options.desktop.ly = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the Ly display manager";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        bigclock = true;
        # blank_password = true;
      };
    };
  };
}
