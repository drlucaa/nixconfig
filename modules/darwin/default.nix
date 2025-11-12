{ hostname, username, ... }:
{
  imports = [
    ./users.nix
    ./homebrew.nix
  ];

  nix.enable = true;

  networking.hostName = hostname;

  home-manager.users.${username}.programs.fish.shellAbbrs = {
    nrs = "sudo darwin-rebuild switch --flake ~/nixconfig#${hostname}";
  };

  system.primaryUser = "${username}";

  system.stateVersion = 6;
}
