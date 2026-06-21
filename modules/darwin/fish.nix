{
  pkgs,
  username,
  ...
}:
{
  programs.fish = {
    enable = true;
    package = pkgs.fish;
  };

  users.users.${username}.shell = pkgs.fish;
}
