{ self, inputs, ... }:
let
  darwin = import ./darwin.nix {
    self = self;
    inputs = inputs;
  };
in
{
  inherit (darwin) mkDarwinHost genDarwinHosts;
}
