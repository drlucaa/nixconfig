{ username, ... }:
{
  config.darwin.homebrew.extraCasks = [ "jetbrains-toolbox" ];
  config.home-manager.users.${username} = {
    modules.programs.mise.enable = true;
  };
}
