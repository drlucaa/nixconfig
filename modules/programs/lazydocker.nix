{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.lazydocker;
in
{
  options.modules.programs.lazydocker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable lazydocker";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.lazydocker = {
          enable = true;
          package = pkgs.unstable.lazydocker;
        };
      };
  };
}

