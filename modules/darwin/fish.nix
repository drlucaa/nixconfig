{
  pkgs,
  username,
  ...
}:
{
  programs.fish = {
    enable = true;
    package = pkgs.unstable.fish;
  };

  users.users.${username}.shell = pkgs.unstable.fish;
}
