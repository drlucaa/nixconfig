{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.modules.boot.plymouth;
in
{
  options.modules.boot.plymouth = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.consoleMode = "max";
        efi.canTouchEfiVariables = true;
        timeout = 1;
      };

      kernelPackages = pkgs.linuxPackages_latest;

      # Plymouth and silent boot settings
      plymouth = lib.mkIf cfg {
        enable = true;
        theme = "spinner_alt";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "spinner_alt" ];
          })
        ];
      };

      # Kernel parameters for a quieter boot experience when Plymouth is enabled
      kernelParams = lib.mkIf cfg [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];

      consoleLogLevel = lib.mkIf cfg 3;
      initrd.verbose = lib.mkIf cfg false;
    };

    # Enable systemd in initrd for Plymouth
    boot.initrd.systemd.enable = lib.mkIf cfg true;
  };
}
