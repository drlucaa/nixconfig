{
  pkgs,
  ...
}:
{
  programs.eza = {
    enable = true;
    package = pkgs.eza;

    enableFishIntegration = true;
    icons = "auto";
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header"
      "--hyperlink"
    ];
  };
  programs.fish.shellAbbrs = {
    et = "eza --tree";
  };
}
