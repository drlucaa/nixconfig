{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    xdg.configFile."aerospace/aerospace.toml".text =
      builtins.replaceStrings
        [ "@ghostty_package@" "@zed_package@" ]
        [ "${config.programs.ghostty.package}" "${config.programs.zed-editor.package}" ]
        (builtins.readFile ../../../config/aerospace.toml);
  };
}
