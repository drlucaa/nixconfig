{
  pkgs,
  ...
}:
{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
