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
    ./tailscale.nix
  ];

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  nix.enable = true;

  networking.hostName = hostname;

  system.stateVersion = 6;
}
