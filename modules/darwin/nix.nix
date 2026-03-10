{
  determinateNix = {
    enable = true; # Tells nix-darwin to let Determinate handle Nix

    # Custom settings go here (written to /etc/nix/nix.custom.conf)
    customSettings = {
      download-buffer-size = 524288000;
      # Note: flakes and nix-command are enabled by default in Determinate
      experimental-features = "nix-command flakes";
    };
  };
}