{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.bottom = {
          enable = true;
          package = pkgs.bottom;
        };
      };
  };
}
