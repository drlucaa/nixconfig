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
          linctl
          pkgs.unstable.zed-editor
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
