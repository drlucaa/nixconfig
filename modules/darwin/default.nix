{
  imports = [
    ./users.nix
    ./homebrew.nix
  ];

  nix.enable = true;

  system.stateVersion = 6;
}
