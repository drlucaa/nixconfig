{
  pkgs,
  self,
  ...
}:
let
  ignores = import "${self}/config/ignores.nix";
  ignoreGlob = builtins.concatStringsSep "|" ignores;
in
{
  programs.eza = {
    enable = true;
    package = pkgs.eza;

    enableFishIntegration = true;
    icons = "auto";
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header"
      "--hyperlink"
    ];
  };
  programs.fish.functions.et = ''
    eza --tree --ignore-glob "${ignoreGlob}"
  '';
}
