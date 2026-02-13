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
            "gitlab.dvbern.ch" = {
              user = "git";
              identityFile = "~/.ssh/dvb-gitlab-key.pub";
              identitiesOnly = true;
            };
            "github.com" = {
              user = "git";
              identityFile = "~/.ssh/private-github-key.pub";
              identitiesOnly = true;
            };
            "gitlab.com" = {
              user = "git";
              identityFile = "~/.ssh/private-gitlab-key.pub";
              identitiesOnly = true;
            };
            "46.225.*.*" = {
              identityFile = "~/.ssh/hetzner-key.pub";
              identitiesOnly = true;
              userKnownHostsFile = "/dev/null";
            };
          };
        };
      };
  };
}
