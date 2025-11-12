{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.pay-respects = {
          enable = true;
          package = pkgs.unstable.pay-respects;
          enableFishIntegration = true;
        };
      };
  };
}
