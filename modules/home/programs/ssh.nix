{
  username,
  pkgs,
  ...
}:
let
  onePassPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";

in
{
  config = {
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
