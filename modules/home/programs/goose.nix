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
            todo:
              enabled: true
              type: platform
              name: todo
              description: Enable a todo list for Goose so it can keep track of what it is doing
              bundled: true
              available_tools: []
            extensionmanager:
              enabled: true
              type: platform
              name: Extension Manager
              description: Enable extension management tools for discovering, enabling, and disabling extensions
              bundled: true
              available_tools: []
            chatrecall:
              enabled: true
              type: platform
              name: chatrecall
              description: Search past conversations and load session summaries for contextual memory
              bundled: true
              available_tools: []
        '';
      };
  };
}
