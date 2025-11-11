{
  username,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.ssh;
  onePassPath = "~/.1password/agent.sock";

in
{
  options.modules.programs.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable ssh";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { ... }:
      {
        programs.ssh = {
          enable = true;
          extraConfig = ''
            Host *
              IdentityAgent ${onePassPath}
          '';
        };
      };
  };
}
