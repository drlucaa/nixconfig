{
  self,
  inputs,
  ...
}:
let
  mkLinux =
    hostDir:
    {
      arch ? "x86_64-linux",
      hostname ? hostDir,
      username ? "luca",
    }:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = arch;
        config.allowUnfree = true;
      };
      pkgs = import inputs.nixpkgs {
        system = arch;
        config.allowUnfree = true;
        overlays = [
          (
            final: prev:
            inputs.nixpkgs.lib.packagesFromDirectoryRecursive {
              callPackage = prev.callPackage;
              directory = ../pkgs;
            }
          )
        ];
      };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit
          inputs
          self
          hostname
          username
          pkgs-unstable
          ;
      };
      modules = [
        inputs.nix-index-database.hmModules.nix-index

        "${self}/modules/home"
        "${self}/hosts/linux/${hostDir}"

        {
          home = {
            username = username;
            homeDirectory = "/home/${username}";
          };
        }
      ];
    };
in
{
  mkLinux = mkLinux;
  genLinuxs = builtins.mapAttrs mkLinux;
}
