{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.pay-respects;
in
{
  options.modules.programs.pay-respects = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable pay-respects";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.pay-respects = {
          enable = true;
          package = pkgs.unstable.pay-respects;
          enableFishIntegration = true;
        };
      };
  };
}
