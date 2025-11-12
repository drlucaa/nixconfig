{ hostname, username, ... }:
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

  home-manager.users.${username}.programs.fish.shellAbbrs = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixconfig#${hostname}";
  };

  networking.hostName = hostname;
  system.stateVersion = "25.05";
}
