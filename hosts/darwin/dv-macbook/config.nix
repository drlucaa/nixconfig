{ config, ... }:
{
  config.darwin.homebrew.extraCasks = [ "jetbrains-toolbox" ];
  config.modules.programs.mise.enable = true;
}
