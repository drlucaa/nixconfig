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

  onePassSignerPath =
    if pkgs.stdenv.hostPlatform.isLinux then
      # Use lib.getExe' and reference the unstable package from your 1password.nix
      (lib.getExe' pkgs.unstable._1password-gui "op-ssh-sign")
    else if pkgs.stdenv.hostPlatform.isDarwin then
      # NOTE: Assumed path for 1Password signer on macOS
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else
      ""; # Fallback for other systems
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
              sign-on-push = true;
              auto-local-bookmark = true;
              track-default-bookmark-on-clone = true;
            };

            signing = {
              behavior = "drop";
              backend = "ssh";
              backends.ssh.program = onePassSignerPath;
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
