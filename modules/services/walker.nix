{
  inputs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.appLauncher.walker;
in
{
  options.modules.appLauncher.walker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable walker app launcher";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { ... }:
      {
        imports = [ inputs.walker.homeManagerModules.default ];
        programs.walker = {
          enable = true;
          runAsService = true;
        };
      };
  };
}
