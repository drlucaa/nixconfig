{
  homebrew = {
    enable = true;
    brews = [
      "block-goose-cli"
      "mas"
    ];
    casks = [
      "1password"
      "spotify"
      "raycast"
      "arc"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
    onActivation.cleanup = "zap";
  };
}
