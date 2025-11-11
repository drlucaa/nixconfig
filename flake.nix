{
  description = "Luca Fondo NixOs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap.url = "github:xremap/nix-flake";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.elephant.follows = "elephant";
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    goose = {
      url = "github:block/goose";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      ...
    }@inputs:
    let
      lib = import ./lib {
        inherit self inputs;
      };
    in
    {
      nixosConfigurations = lib.genHosts {
        desktop-luca = { };

        vm-mac = {
          arch = "aarch64-linux";
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
