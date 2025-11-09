{
  inputs,
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.goose;
in
{
  options.modules.programs.goose = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable goose agent";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = [
          inputs.goose.defaultPackage.${pkgs.system}
        ];
      };
  };
}
