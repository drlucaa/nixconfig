{ self, inputs, ... }:
let
  darwin = import ./darwin.nix { inherit self inputs; };
  linux = import ./linux.nix { inherit self inputs; };
in
{
  inherit (darwin) mkDarwinHost genDarwinHosts;
  inherit (linux) mkLinux genLinuxs;
}
