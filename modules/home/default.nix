{
  username,
  inputs,
  ...
}:
{

  imports = [
    ./programs
  ];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.${username} =
      { ... }:
      {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
        ];

        catppuccin.enable = true;

        home.stateVersion = "25.05";
      };
  };
}
