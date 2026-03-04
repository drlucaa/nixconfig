{
  pkgs,
  self,
  ...
}:
let
  ignores = import "${self}/config/ignores.nix";
in
{
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;
    arguments = [
      "--max-columns=150"
      "--max-columns-preview"
      "--hidden"
      "--smart-case"
    ]
    ++ (map (i: "--glob=!${i}") ignores);
  };
}
