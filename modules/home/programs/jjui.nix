{
  pkgs,
  ...
}:
{
  programs.jjui = {
    enable = true;
    package = pkgs.unstable.jjui;
  };

  programs.fish.shellAbbrs = {
    ju = "jjui";
  };
}
