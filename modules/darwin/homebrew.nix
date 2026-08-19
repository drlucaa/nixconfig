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
        "felixkratz/formulae"
        "netbirdio/tap"
        "nikitabobko/tap"
        "tabularisdb/tabularis"
        "oomol-lab/tap"
      ];
      brews = [
        "FelixKratz/formulae/borders"
        "mas"
        "mole"
        "netbirdio/tap/netbird"
      ]
      ++ cfg.extraBrews;

      casks = [
        "1password"
        "1password-cli"
        "activitywatch"
        "affinity"
        "logi-options+"
        "netbirdio/tap/netbird-ui"
        "nikitabobko/tap/aerospace"
        "oomol-lab/tap/lockime"
        "orbstack"
        "raycast"
        "signal"
        "spotify"
        "tabularisdb/tabularis/tabularis"
        "zen"
      ]
      ++ cfg.extraCasks;

      masApps = {
        "1Password for Safari" = 1569813296;
        "Toggle Track" = 1291898086;
        "Things 3" = 904280696;
      };
      onActivation.cleanup = "zap";
      # disabled because of a mas issue https://github.com/zhaofengli/nix-homebrew/issues/131
      onActivation.autoUpdate = false;
      onActivation.upgrade = true;
    };
  };
}
