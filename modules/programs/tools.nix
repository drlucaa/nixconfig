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
          pkgs.unstable.docker-language-server
          pkgs.unstable.delve
          pkgs.unstable.gopls
          pkgs.unstable.helm-ls
          pkgs.unstalbe.prettier
          pkgs.unstalbe.superhtml
          pkgs.unstalbe.taplo
          pkgs.unstalbe.templ
          pkgs.unstalbe.yaml-language-server
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
