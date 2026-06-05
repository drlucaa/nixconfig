{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    devenv
  ];

  programs.fish.shellAbbrs = {
    "d" = "devenv";
  };
}
