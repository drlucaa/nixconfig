{
  inputs,
  ...
}:
{
  imports = [
    ./programs
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.enable = true;
  home.stateVersion = "25.05";
}
