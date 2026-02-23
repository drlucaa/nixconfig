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

          package = pkgs.ghostty-bin;

          settings = {
            font-size = if pkgs.stdenv.hostPlatform.isDarwin then 16 else 10;
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
