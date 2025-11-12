{
  username,
  pkgs,
  userDescription,
  ...
}:
{
  users.users.${username} = {
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.fish;
  };

  system.primaryUser = "${username}";
}
