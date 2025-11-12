{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.git;
in
{

  options.modules.programs.git = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "Luca Fondo";
      description = "Name for git commits";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "luca.fondo@trai.ch";
      description = "Email for git commits";
    };
  };

  config = {
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
