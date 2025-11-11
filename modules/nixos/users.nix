{
  pkgs,
  username,
  userDescription,
  ...
}:
{
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
  };

  # set default passwords for vm builds
  virtualisation.vmVariant = {
    users.users = {
      root.password = "root";
      ${username}.password = username;
    };
  };
}
