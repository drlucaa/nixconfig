{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.lazydocker = {
          enable = true;
          package = pkgs.unstable.lazydocker;
        };

        programs.fish.shellAbbrs = {
          ld = "lazydocker";
        };
      };
  };
}
