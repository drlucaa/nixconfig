{
  lib,
  config,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.programs.jujutsu;
  gitCfg = config.modules.programs.git;
in
{

  options.modules.programs.jujutsu = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable jujutsu";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, config, ... }:
      {
        programs.jujutsu = {
          enable = true;
          package = pkgs.jujutsu;

          settings = {
            user = {
              name = gitCfg.name;
              email = gitCfg.email;
            };

            ui = {
              default-command = "log";
              editor = "${config.programs.helix.package}/bin/hx";
              color = "always";
              paginate = "auto";
            };

            git = {
              # TODO: after setting up 1pasword ssh agent
              sign-on-push = true;
              auto-local-bookmark = true;
              track-default-bookmark-on-clone = true;
            };

            signing = {
              behavior = "drop";
              backend = "ssh";
              backends.ssh.program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
              key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEczwOyJv9eAYANotcE0iB8dlFOWT1WE1ce8EgVHtp6X";
            };

            merge-tools.delta = {
              program = "${pkgs.delta}/bin/delta";
              diff-expected-exit-codes = [
                0
                1
              ];
              diff-args = [
                "--file-transformation"
                "s,^[12]/tmp/jj-diff-[^/]*/,,"
                "$left"
                "$right"
              ];
            };
          };
        };
      };
  };
}
