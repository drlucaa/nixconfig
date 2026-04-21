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
        "FelixKratz/formulae"
        "dgunzy/tap"
        "nikitabobko/tap"
        "traiproject/tap"
      ];
      brews = [
        "FelixKratz/formulae/borders"
        "block-goose-cli"
        "dgunzy/tap/flux9s"
        "mas"
        "ollama"
        "openssl@3"
      ]
      ++ cfg.extraBrews;

      casks = [
        "1password"
        "1password-cli"
        "affinity"
        "antigravity"
        "arc"
        "dbeaver-community"
        "deepl"
        "docker-desktop"
        "figma"
        "linear-linear"
        "nikitabobko/tap/aerospace"
        "orbstack"
        "raycast"
        "spotify"
        "traiproject/tap/same"
        "twingate"
        "utm"
        "zed"
        "zen"
      ]
      ++ cfg.extraCasks;

      masApps = {
        "1Password for Safari" = 1569813296;
        "Toggle Track" = 1291898086;
        "Things 3" = 904280696;
      };
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };
  };
}
