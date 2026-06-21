{
  pkgs,
  ...
}:
{
  programs.pay-respects = {
    enable = true;
    package = pkgs.pay-respects;
    enableFishIntegration = true;
  };
}
