{
  config,
  lib,
  username,
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

  config = lib.mkIf cfg.enable {
    programs._1password-gui = {
      enable = true;
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
