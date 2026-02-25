{
  description = "Luca Fondo Nix-Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    let
      lib = import ./lib { inherit self inputs; };
    in
    flake-parts.lib.mkFlake { inherit self inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      flake = {
        darwinConfigurations = lib.genDarwinHosts {
          lucas-macbook = { };
          dv-macbook = {
            username = "luca.fondo";
          };
          mac-mini = {
            username = "ycs";
          };
        };
        lib = lib;
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells = import ./shells { inherit pkgs; };
        };
    };
}
