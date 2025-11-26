{
  nix = {
    settings = {
      download-buffer-size = 524288000;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;

      # Run GC every day at 03:00
      interval = [
        {
          Hour = 12;
          Minute = 15;
        }
      ];

      # Only delete store paths older than 7 days
      options = "--delete-older-than 7d";
    };
  };
}
