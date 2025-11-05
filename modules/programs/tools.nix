{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.tools;
in
{
  options.modules.programs.tools = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tools";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          fd
          fzf
          ripgrep
          jq
          fq
          age
          tlrc
          vscode-langservers-extracted
          pkgs.unstable.delve
          pkgs.unstable.gopls
          pkgs.unstable.helm-ls
          pkgs.unstable.prettier
          pkgs.unstable.superhtml
          pkgs.unstable.taplo
          pkgs.unstable.templ
          pkgs.unstable.yaml-language-server
          # TODO: bring in oncepr https://github.com/NixOS/nixpkgs/pull/458418 is resolved
          # pkgs.unstable.docker-language-server
          pkgs.unstable.jocalsend
          pkgs.unstable.yatto
          pkgs.unstable.gemini-cli
        ];

        xdg.configFile = {
          "yatto/config.toml".source = ../../confs/yatto/config.toml;
        };
      };
  };
}
