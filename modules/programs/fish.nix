{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.fish;
in {
  options.modules.programs.fish = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the fish";
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
    users = {
      defaultUserShell = pkgs.fish;
    };
  };
}
