{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.zoxide;
in
{
  options.modules.programs.zoxide = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zoxide";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
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
