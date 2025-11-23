{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.gh = {
          enable = true;
          package = pkgs.gh;
        };
      };
  };
}
