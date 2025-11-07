{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.lazygit;
in
{
  options.modules.programs.lazygit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable lazygit";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.lazygit = {
          enable = true;
          package = pkgs.unstable.lazygit;
        };

        programs.fish.shellAbbrs = {
          lg = "lazygit";
        };
      };
  };
}

