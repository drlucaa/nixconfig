{ self, inputs, ... }:
let
  hosts = import ./hosts.nix {
    self = self;
    inputs = inputs;
  };
  darwin = import ./darwin.nix {
    self = self;
    inputs = inputs;
  };
  vm = import ./vm.nix {
    inputs = inputs;
  };
in
{
  inherit (hosts) mkHost genHosts;
  inherit (darwin) mkDarwinHost genDarwinHosts;
  inherit (vm) mkVMApp;
}
