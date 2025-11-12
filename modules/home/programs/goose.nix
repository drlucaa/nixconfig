{
  inputs,
  username,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = [
          inputs.goose.defaultPackage.${pkgs.system}
        ];
      };
  };
}
