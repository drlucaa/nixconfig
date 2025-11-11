{
  imports = [
    ./core
    ./services
    ./desktop
    ./graphics.nix
    ./virtualisation.nix
    ./nix.nix
    ./users.nix
  ];

  system.stateVersion = "25.05";
}
