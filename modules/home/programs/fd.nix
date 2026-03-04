{
  pkgs,
  self,
  ...
}:
let
  ignores = import "${self}/config/ignores.nix";
in
{
  programs.fd = {
    enable = true;
    package = pkgs.fd;
    ignores = ignores;
    hidden = true;
  };
}
