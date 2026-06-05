{
  pkgs,
  ...
}:
{
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
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
