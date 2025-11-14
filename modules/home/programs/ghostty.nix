{
  username,
  config,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.ghostty = {
          enable = true;
          enableFishIntegration = true;

          package =
            if pkgs.stdenv.hostPlatform.isLinux then pkgs.unstable.ghostty else pkgs.unstable.ghostty-bin;

          settings = {
            font-size = 16;
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
