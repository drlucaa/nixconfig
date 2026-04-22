{
  username,
  uid,
  ...
}:
{
  users.knownUsers = [ username ];

  users.users.${username} = {
    home = "/Users/${username}";
    isHidden = false;
    uid = uid;
  };

  system.primaryUser = "${username}";
}
