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
        "traiproject/tap"
        "fluxcd/tap"
      ];
      brews = [
        "block-goose-cli"
        "FelixKratz/formulae/borders"
        "mas"
        "fluxcd/tap/flux"
      ]
      ++ cfg.extraBrews;

      casks = [
        "nikitabobko/tap/aerospace"
        "antigravity"
        "affinity"
        "zen"
        "1password"
        "spotify"
        "raycast"
        "arc"
        "linear-linear"
        "docker-desktop"
        "traiproject/tap/same"
        "zed"
      ]
      ++ cfg.extraCasks;

      masApps = {
        "1Password for Safari" = 1569813296;
      };
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };
  };
}
