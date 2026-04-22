{
  pkgs,
  ...
}:
{
  programs.direnv = {
    enable = true;
    package = pkgs.direnv.overrideAttrs (old: {
      doCheck = false;
    });
    nix-direnv.enable = true;
    silent = true;
  };
}
