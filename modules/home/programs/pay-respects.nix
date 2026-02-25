{
  pkgs,
  ...
}:
{
  programs.pay-respects = {
    enable = true;
    package = pkgs.unstable.pay-respects;
    enableFishIntegration = true;
  };
}
