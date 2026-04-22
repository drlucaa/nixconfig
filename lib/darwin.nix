{ self, inputs, ... }:
let
  mkDarwinHost =
    hostDir:
    {
      arch ? "aarch64-darwin",
      hostname ? hostDir,
      username ? "folu",
      uid ? 501,
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
          uid
          userDescription
          ;
      };
      modules = [
        inputs.determinate.darwinModules.default
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-index-database.darwinModules.nix-index

        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "${username}";
          };
        }

        {
          home-manager = {
            useGlobalPkgs = true;
            backupFileExtension = "hmBackup";

            extraSpecialArgs = {
              inherit
                inputs
                self
                hostname
                username
                uid
                userDescription
                ;
            };

            users.${username} = {
              imports = [ "${self}/modules/home" ];
            };
          };
        }

        "${self}/modules/darwin"
        "${self}/modules/common"

        "${self}/hosts/darwin/${hostDir}"
      ];
    };
in
{
  mkDarwinHost = mkDarwinHost;
  genDarwinHosts = builtins.mapAttrs mkDarwinHost;
}
