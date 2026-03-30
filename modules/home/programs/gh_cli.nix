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
    NIX_CONFIG = "access-tokens = github.com=$GITHUB_TOKEN";
  };
}
