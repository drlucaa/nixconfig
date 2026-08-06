{
  hostname,
  ...
}:
{
  imports = [
    ./users.nix
    ./homebrew.nix
    ./system.nix
    ./nix.nix
    ./fish.nix
  ];

  nix.enable = true;

  networking.hostName = hostname;

  system.stateVersion = 6;
}
