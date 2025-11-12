{
  lib,
  pkgs,
  username,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    home-manager.users.${username} = {
      home.packages = [
        pkgs.unstable.spotify
      ];
    };
  };
}
