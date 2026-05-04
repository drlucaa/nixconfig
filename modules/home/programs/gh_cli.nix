{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    package = pkgs.gh;
  };

  home.sessionVariables = {
    GITHUB_TOKEN = "$(gh auth token)";
  };
}
