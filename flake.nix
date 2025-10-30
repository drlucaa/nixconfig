{
  description = "Géza's NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      lib = import ./lib {
        inherit self inputs;
      };
    in
    {
      nixosConfigurations = lib.genHosts {
        desktop-luca = {
          username = "luca";
          userDescription = "Luca Fondo";
        };
      };

      # Development shells in ./shells
      devShells = lib.eachSystem (pkgs: import ./shells { inherit pkgs; });

      # Easily run as VM with `nix run`
      apps = lib.eachSystem (pkgs: rec {
        default = desktop-luca;

        desktop-luca = lib.mkVMApp "desktop-luca";
      });
      # Library functions for external use
      lib = lib;
    };
}
