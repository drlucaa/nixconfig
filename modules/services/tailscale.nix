{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.service.tailscale;
in
{
  options.modules.service.tailscale = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tailscale";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          tailscale
        ];
      };
  };
}
