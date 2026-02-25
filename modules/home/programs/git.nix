{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.programs.git;

  onePassSignerPath = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  sshSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEczwOyJv9eAYANotcE0iB8dlFOWT1WE1ce8EgVHtp6X";
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
    programs.git = {
      enable = true;
      package = pkgs.git;

      settings = {
        user = {
          name = cfg.name;
          email = cfg.email;
          signingkey = sshSigningKey;
        };

        gpg.format = "ssh";
        "gpg \"ssh\"".program = onePassSignerPath;
        commit.gpgsign = true;

        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        core.editor = "${config.programs.helix.package}/bin/hx";
      };

      ignores = [
        ".DS_Store"
        "Desktop.ini"
        "._*"
        "Thumbs.db"
        ".Spotlight-V100"
        ".Trashes"
        ".idea/"
        "*.log"
        ".idea/"
      ];
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
}
