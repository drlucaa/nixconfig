{ config, lib, ... }:
let
  cfg = config.darwin.homebrew;
in
{
  options.darwin.homebrew = {
    ableton = lib.mkEnableOption "Weather to install ableton";
    rekordbox = lib.mkEnableOption "Weather to install ableton";
    jetbrains-toolbox = lib.mkEnableOption "Weather to install jetbrains-toolbox";
    dropbox = lib.mkEnableOption "Weather to install dropbox";
  };

  config = {
    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      brews = [
        "block-goose-cli"
        "borders"
        "mas"
        "docker"
      ];

      casks = [
        "aerospace"
        "1password"
        "spotify"
        "raycast"
        "arc"
        "linear-linear"
      ]
      ++ lib.optionals cfg.ableton [
        "ableton-live-standard"
      ]
      ++ lib.optionals cfg.rekordbox [
        "rekordbox"
      ]
      ++ lib.optionals cfg.dropbox [
        "dropbox"
      ]
      ++ lib.optionals cfg.jetbrains-toolbox [
        "jetbrains-toolbox"
      ];

      masApps = {
        "1Password for Safari" = 1569813296;
      };
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };
  };
}
