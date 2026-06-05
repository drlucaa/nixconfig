{
  pkgs,
  ...
}:
{
  programs.lazydocker = {
    enable = true;
    package = pkgs.lazydocker;
  };

  programs.fish.shellAbbrs = {
    ld = "lazydocker";
  };
}
