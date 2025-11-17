{
  inputs,
  username,
  lib,
  ...
}:
{
  config = {
    environment.variables = {
      RUST_LOG = "goose::providers::lead_worker=info";
    };

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
          inputs.goose.defaultPackage.${pkgs.stdenv.hostPlatform.system}
        ];

        xdg.configFile."goose/config.yaml".text = ''
          GOOSE_PROVIDER: openrouter
          GOOSE_LEAD_MODEL: anthropic/claude-sonnet-4.5
          GOOSE_MODEL: qwen/qwen3-coder
          GOOSE_CLI_SHOW_COST: true

          extensions:
            developer:
              enabled: true
              type: builtin
              name: developer
              description: Code editing and shell access
              display_name: Developer Tools
              timeout: 300
              bundled: true
              available_tools: []
        '';
      };
  };
}
