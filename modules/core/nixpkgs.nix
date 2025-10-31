{
  inputs,
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
          system = prev.system;
          config.allowUnfree = true;
        };
      })
    ];
    # overlays = [
    #   (
    #     final: prev:
    #     lib.packagesFromDirectoryRecursive {
    #       callPackage = prev.callPackage;
    #       directory = ../../pkgs;
    #     }
    #   )
    # ];
  };
}
