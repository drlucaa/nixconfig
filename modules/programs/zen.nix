{
  inputs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.programs.zen;
in
{
  options.modules.programs.zen = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zen browser";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        imports = [ inputs.zen-browser.homeModules.beta ];
        programs.zen-browser = {
          enable = true;
          profiles."default" = {
            containersForce = true;
            spacesForce = true;
            spaces = {
              "Personal" = {
                id = "c6de089c-410d-4206-961d-ab11f988d40a";
                icon = "chrome://browser/skin/zen-icons/selectable/sun.svg";
                position = 1000;
              };
              "Trai" = {
                id = "cdd10fab-4fc5-494b-9041-325e5759195b";
                icon = "chrome://browser/skin/zen-icons/selectable/terminal.svg";
                position = 2000;
              };
            };

          };
        };
        programs.zen-browser.policies =
          let
            mkExtensionSettings = builtins.mapAttrs (
              _: pluginId: {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
                installation_mode = "force_installed";
              }
            );
          in
          {
            ExtensionSettings = mkExtensionSettings {
              "wappalyzer@crunchlabz.com" = "wappalyzer";
              "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
            };
          };
      };
  };
}
