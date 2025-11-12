{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
  };
}
