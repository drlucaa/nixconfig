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
      { ... }:
      {
        imports = [ inputs.zen-browser.homeModules.beta ];
        programs.zen-browser = {
          enable = true;
        };
      };
  };
}
