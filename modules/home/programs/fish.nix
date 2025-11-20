{
  username,
  ...
}:
{
  config = {
    programs.fish.enable = true;

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
          package = pkgs.fish;

          shellAbbrs = {
            rd = "rm -rf";
            c = "clear";

            # nix
            ngc = "sudo nix-collect-garbage -d";
            nd = "nix develop";
          };

          plugins = [
            {
              name = "tide";
              src = pkgs.fishPlugins.tide.src;
            }
            {
              name = "autopair";
              src = pkgs.fishPlugins.autopair.src;
            }
            {
              name = "fzf";
              src = pkgs.fishPlugins.fzf.src;
            }
            {
              name = "puffer";
              src = pkgs.fishPlugins.puffer.src;
            }
          ];

          functions = {
            fish_greeting = ''
              if not set -q _tide_left_items
                tide configure
              end
              fastfetch
            '';
            cx = "mkdir -p $argv && cd $argv";
          };
        };
      };
  };
}
