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
    users.defaultUserShell = pkgs.fish;

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
          package = pkgs.fish;

          shellAbbrs = {
            ju = "jjui";
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
            fish_greeting = "fastfetch";
          };
        };
      };
  };
}
