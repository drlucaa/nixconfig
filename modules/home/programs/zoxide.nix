{
  pkgs,
  self,
  ...
}:
let
  ignores = import "${self}/config/ignores.nix";
in
{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  home.sessionVariables._ZO_EXCLUDE_DIRS = builtins.concatStringsSep ":" ignores;
}
