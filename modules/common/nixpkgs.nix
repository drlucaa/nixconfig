{
  inputs,
  lib,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      })
      (
        final: prev:
        lib.packagesFromDirectoryRecursive {
          callPackage = prev.callPackage;
          directory = ../../pkgs;
        }
      )

    ];
  };
}
