{ config, ... }:
{
  config.darwin.homebrew.jetbrains-toolbox = true;
  config.modules.programs.mise.enable = true;
}
