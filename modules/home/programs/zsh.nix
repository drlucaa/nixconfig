{ username, ... }:
{
  config = {
    programs.zsh.enable = true;

    home-manager.users.${username} =
      { ... }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          shellAliases = {
            c = "clear";
            k = "kubectl";
            kx = "kubectx";
            f9 = "flux9s";
            ngc = "sudo nix-collect-garbage -d";
            nd = "nix develop";

            tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
            tscp = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
            mkdir = "mkdir -p";
            rd = "rm -rf";
          };

          initExtra = ''
            # Custom function translated from fish 'cx' abbr
            cx() {
              mkdir -p "$1" && cd "$1"
            }

            # Run fastfetch on startup
            fastfetch
          '';
        };

        programs.starship = {
          enable = true;
          enableZshIntegration = true;
        };
      };
  };
}
