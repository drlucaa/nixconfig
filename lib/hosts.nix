{ self, inputs, ... }:
let
  mkHost =
    hostDir:
    {
      arch ? "x86_64-linux",
      hostname ? hostDir,
      username ? "luca",
      userDescription ? "Luca Fondo",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      specialArgs = {
        inherit
          inputs
          self
          hostname
          username
          userDescription
          ;
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.niri.nixosModules.niri
        inputs.disko.nixosModules.disko
        inputs.nix-index-database.nixosModules.nix-index
        inputs.xremap.nixosModules.default

        "${self}/modules/nixos"
        "${self}/modules/common"
        "${self}/modules/home"

        "${self}/hosts/nixos/${hostDir}"
      ];
    };
in
{
  mkHost = mkHost;
  genHosts = builtins.mapAttrs mkHost;
}
