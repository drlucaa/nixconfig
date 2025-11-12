{
  pkgs,
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} = {
      programs.fastfetch = {
        enable = true;
        package = pkgs.fastfetch;
      };
    };
  };
}
