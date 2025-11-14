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
          ];

          functions = {
            fish_greeting = ''
              if not set -q _tide_left_items
                tide configure
              end
              fastfetch
            '';
          };
        };
      };
  };
}
