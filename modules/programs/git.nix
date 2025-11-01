{
  lib,
  config,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.programs.git;
in
{

  options.modules.programs.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable git";
    };

    name = mkOption {
      type = types.str;
      default = "Luca Fondo";
      description = "Name for git commits";
    };

    email = mkOption {
      type = types.str;
      default = "luca.fondo@trai.ch";
      description = "Email for git commits";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, config, ... }:
      {
        programs.git = {
          enable = true;
          package = pkgs.git;

          settings = {
            user = {
              name = cfg.name;
              email = cfg.email;
            };

            push.autoSetupRemote = true;
            init.defaultBranch = "main";
            core.editor = "${config.programs.helix.package}/bin/hx";
          };

        };
        programs.delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            side-by-side = true;
          };
        };

      };
  };
}
