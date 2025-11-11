{
  imports = [
    ./users.nix
  ];

  services.nix-daemon.enable = true;

  system.stateVersion = 6;
}
