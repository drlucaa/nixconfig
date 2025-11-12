{ config, ... }:
{
  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "block-goose-cli"
      "borders"
      "mas"
    ];
    casks = [
      "aerospace"
      "1password"
      "spotify"
      "raycast"
      "arc"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
