{
  config,
  lib,
  username,
  pkgs,
  ...
}:
let
  cfg = config.modules.programs.onepassword;
in
{
  options.modules.programs.onepassword = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable onepassword";
    };
  };

  config = lib.mkIf (cfg.enable && pkgs.stdenv.isLinux) {
    programs._1password-gui = {
      enable = true;
      package = pkgs.unstable._1password-gui;
      polkitPolicyOwners = [ "${username}" ];
    };

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          zen
        '';
        mode = "0755";
      };
    };  };
}
