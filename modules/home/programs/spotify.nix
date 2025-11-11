{
  lib,
  config,
  pkgs,
  username,
  ...
}:
with lib;
let
  cfg = config.modules.programs.spotify;
in
{
  options.modules.programs.spotify = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable spotify";
    };
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isLinux) {
    home-manager.users.${username} = {
      home.packages = [
        pkgs.unstable.spotify
      ];
    };
  };
}
