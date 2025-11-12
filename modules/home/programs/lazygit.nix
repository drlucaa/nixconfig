{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.lazygit = {
          enable = true;
          package = pkgs.unstable.lazygit;
        };

        programs.fish.shellAbbrs = {
          lg = "lazygit";
        };
      };
  };
}
