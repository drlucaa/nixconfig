{
  lib,
  config,
  username,
  ...
}:

let
  cfg = config.modules.programs.direnv;
in
{
  options.modules.programs.direnv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable direnv and nix-direnv for the user.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
  };
}
