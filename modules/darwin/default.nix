{ hostname, username, ... }:
{
  imports = [
    ./users.nix
    ./homebrew.nix
    ./system.nix
    ./nix.nix
  ];

  programs.fish.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  nix.enable = true;

  networking.hostName = hostname;

  home-manager.users.${username}.programs.fish.shellAbbrs = {
    nrs = "sudo darwin-rebuild switch --flake ~/nixconfig#${hostname}";
  };

  system.stateVersion = 6;
}
