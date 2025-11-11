{
  pkgs,
  lib,
  config,
  username,
  hostname,
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

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
          package = pkgs.fish;

          shellAbbrs = {
            rd = "rm -rf";

            # nix
            nrs = "sudo nixos-rebuild switch --flake ~/nixconfig#${hostname}";
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
