{
  pkgs,
  ...
}:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
  };

  programs.fish.shellAliases = {
    cat = "bat";
  };
}
