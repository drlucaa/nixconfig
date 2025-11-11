{ self, inputs, ... }:
let
  mkDarwinHost =
    hostDir:
    {
      arch ? "aarch64-darwin",
      hostname ? hostDir,
      username ? "luca",
      userDescription ? "Luca Fondo",
    }:
    inputs.nix-darwin.lib.darwinSystem {
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
        (
          { ... }:
          {
            networking.hostName = hostname;
          }
        )

        inputs.home-manager.darwinModules.home-manager

        "${self}/modules/darwin"
        "${self}/modules/home"

        "${self}/hosts/darwin/${hostDir}"
      ];
    };
in
{
  mkDarwinHost = mkDarwinHost;
  genDarwinHosts = builtins.mapAttrs mkDarwinHost;
}
