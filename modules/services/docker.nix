{
  pkgs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.services.docker;
in
{
  options.modules.services.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable docker";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    users.users.${username}.linger = true;
  };
}
