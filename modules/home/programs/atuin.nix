{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.atuin = {
          enable = true;
          package = pkgs.atuin;
          enableFishIntegration = true;
          daemon.enable = true;
          daemon.logLevel = "debug";
          settings = {
            update_check = false;
            daemon.enalbed = true;
            workspaces = true;
            style = "compact";
            history_filter = [
              "^cd"
              "^cx"
              "^ls"
              "^l"
              "^ll"
              "^jgf"
              "^clear"
              "^c"
              "^exit"
              "^lazygit"
              "^gg"
              "^nvim"
              "^hx$"
              "^jj$"
              "^ju"
              "^jjui"
              "^eza"
            ];
            store_failed = true;
            secrets_filter = true;
            enter_accept = true;
            stats = {
              common_subcommands = [
                "cargo"
                "docker"
                "git"
                "go"
                "jj"
                "kubectl"
                "nix"
                "nmcli"
                "npm"
                "pnpm"
                "systemctl"
                "yarn"
                "nx"
              ];
              common_prefix = [
                "sudo"
              ];
            };
            sync.records = true;
          };
        };
      };
  };
}
