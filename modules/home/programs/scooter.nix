{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.scooter ];

  programs.fish.shellAbbrs = {
    sc = "scooter";
  };
}
