{
  homebrew = {
    enable = true;
    brews = [
      "block-goose-cli"
    ];
    casks = [
      "1password"
      "spotify"
      "raycast"
    ];
    onActivation.cleanup = "zap";
  };
}
