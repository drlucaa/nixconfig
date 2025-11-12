{
  username,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.programs.ssh;
  onePassPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";

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

          enableDefaultConfig = false;

          matchBlocks = {
            "*" = {
              extraOptions = {
                IdentityAgent = "\"${onePassPath}\"";
              };
            };
          };
        };
      };
  };
}
