{
  username,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.ghostty;
in
{
  options.modules.programs.ghostty = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable ghostty terminal";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.ghostty = {
          enable = true;
          enableFishIntegration = true;

          package = pkgs.unstable.ghostty;

          settings = {
            theme = "GitHub Dark Default";
            font-size = 10;
            font-family = "Monaspace Neon";
            mouse-hide-while-typing = true;
            shell-integration = "fish";
            command = "${config.programs.fish.package}/bin/fish";
            keybind = "global:cmd+grave_accent=toggle_quick_terminal";
            quick-terminal-position = "center";
            quick-terminal-size = "60%,40%";
          };
        };
      };
  };
}
