{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.service.openssh;
in
{
  options.modules.service.openssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable openssh";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
