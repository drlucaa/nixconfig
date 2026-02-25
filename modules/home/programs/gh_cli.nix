{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    package = pkgs.gh;
  };
}
