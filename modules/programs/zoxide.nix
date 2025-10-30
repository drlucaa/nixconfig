{
  username,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.zoxide;
in {
  options.modules.programs.zoxide = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable zoxide";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {pkgs, ...}: {
      programs.zoxide = {
        enable = true;
        package = pkgs.zoxide;
        enableFishIntegration = true;
        options = [
          "--cmd cd"
        ];
      };
    };
  };
}
