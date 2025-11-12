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
        inputs.home-manager.darwinModules.home-manager

        inputs.nix-homebrew.darwinModules.default
        {
          nix-homebrew = {
            enable = true;
            # TODO: add if to only add on apple silicon
            enableRosetta = true;
            user = "${username}";
          };
        }

        "${self}/modules/darwin"
        "${self}/modules/common"
        "${self}/modules/home"

        "${self}/hosts/darwin/${hostDir}"
      ];
    };
in
{
  mkDarwinHost = mkDarwinHost;
  genDarwinHosts = builtins.mapAttrs mkDarwinHost;
}
