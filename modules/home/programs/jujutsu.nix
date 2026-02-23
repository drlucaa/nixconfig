{
  config,
  username,
  ...
}:
let
  gitCfg = config.modules.programs.git;

  onePassSignerPath = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  sshSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEczwOyJv9eAYANotcE0iB8dlFOWT1WE1ce8EgVHtp6X";

in
{
  config = {
    home-manager.users.${username} =
      { pkgs, config, ... }:
      {
        programs.jujutsu = {
          enable = true;
          package = pkgs.unstable.jujutsu;

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
            };

            signing = {
              behavior = "drop";
              backend = "ssh";
              backends.ssh.program = onePassSignerPath;
              key = sshSigningKey;
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

        programs.fish.shellAbbrs = {
          jgf = "jj git fetch";
          jgp = "jj git push -b";
          jbm = "jj bookmark move";
        };
      };
  };
}
