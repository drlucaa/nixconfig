{
  ...
}:
let
  onePassPath = "Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";

in
{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "\"~/${onePassPath}\"";
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
      "178.156.246.157" = {
        identityFile = "~/.ssh/hetzner-key.pub";
        identitiesOnly = true;
      };
    };
  };
  home.sessionVariables.SSH_AUTH_SOCK = "$HOME/${onePassPath}";
}
