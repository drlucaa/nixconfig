{
  username,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.programs.eza;
in
{

  options.modules.programs.eza = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable eza";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.eza = {
          enable = true;
          package = pkgs.eza;

          enableFishIntegration = true;
          icons = "auto";
          git = true;

          extraOptions = [
            "--group-directories-first"
            "--no-quotes"
            "--header"
            "--hyperlink"
          ];
        };
      };
  };
}
