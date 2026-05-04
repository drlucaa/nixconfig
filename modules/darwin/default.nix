{
  hostname,
  ...
}:
{
  imports = [
    ./fish.nix
    ./homebrew.nix
    ./nix.nix
    ./paneru.nix
    ./system.nix
    ./users.nix
  ];

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  nix.enable = true;

  networking.hostName = hostname;

  system.stateVersion = 6;
}
