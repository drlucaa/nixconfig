{
  inputs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.zen;
in
{
  options.modules.programs.zen = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zen browser";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        imports = [ inputs.zen-browser.homeModules.beta ];
        programs.zen-browser = {
          enable = true;
        };
      };
  };
}
