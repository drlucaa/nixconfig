{ config, lib, ... }:
let
  cfg = config.darwin.homebrew;
in
{
  options.darwin.homebrew = {
    extraCasks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra casks for homebrew to download";
    };
    extraBrews = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra Brews for homebrew to download";
    };
  };

  config = {
    homebrew = {
      enable = true;
      taps = [
        "nikitabobko/tap"
        "FelixKratz/formulae"
      ];
      brews = [
        "block-goose-cli"
        "borders"
        "mas"
      ]
      ++ cfg.extraBrews;

      casks = [
        "aerospace"
        "1password"
        "spotify"
        "raycast"
        "arc"
        "linear-linear"
        "docker-desktop"
      ]
      ++ cfg.extraCasks;

      masApps = {
        # "1Password for Safari" = 1569813296;
      };
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };
  };
}
