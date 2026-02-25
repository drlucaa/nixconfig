{
  pkgs,
  ...
}:
{
  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
    settings = {
      git = {
        overrideGpg = true;
      };
    };
  };

  programs.fish.shellAbbrs = {
    lg = "lazygit";
  };
}
