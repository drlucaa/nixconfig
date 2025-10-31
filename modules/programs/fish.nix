{
  pkgs,
  lib,
  config,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.programs.fish;
in
{
  options.modules.programs.fish = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable fish shell";
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
          package = pkgs.fish;

          shellAbbrs = {
            ju = "jjui";
          };

          plugins = [
            {
              name = "tide";
              src = pkgs.fishPlugins.tide.src;
            }
          ];

          interactiveShellInit = ''
            set fish_greeting
          '';
        };
      };
  };
}
