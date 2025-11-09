{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.modules.services.xremap;
in
{
  options.modules.services.xremap = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable xremap";
    };
    keyboardType = lib.mkOption {
      type = lib.types.enum [
        "mac"
        "pc"
      ];
      default = "mac";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xremap = {
      enable = true;
      serviceMode = "user";
      userName = "${username}";
      watch = true;
      withNiri = true;

      config = {
        modmap = lib.optionals (cfg.keyboardType == "pc") [
          {
            name = "Mac-like modifier positions (swap Alt ⌥ and Super ⌘)";
            remap = {
              "Alt_L" = "Super_L";
              "Super_L" = "Alt_L";
              "Alt_R" = "Super_R";
              "Super_R" = "Alt_R";
            };
          }
        ];
        keymap = [
          {
            name = "Global: Super acts like macOS Command (to apps)";
            application = {
              not = [
                "com.mitchellh.ghostty"
              ];
            };
            exact_match = false;
            remap = {
              "Super-c" = "C-c";
              "Super-x" = "C-x";
              "Super-v" = "C-v";
              "Super-z" = "C-z";
              "Super-Shift-z" = "C-Shift-z";
              "Super-a" = "C-a";
              "Super-s" = "C-s";
              "Super-f" = "C-f";
              "Super-t" = "C-t";
              "Super-r" = "C-r";
              "Super-l" = "C-l";
              "Super-n" = "C-n";
              "Super-w" = "C-w";

              "Super-Left" = "Home";
              "Super-Right" = "End";
              "Super-Up" = "C-Home";
              "Super-Down" = "C-End";

              "Alt-Left" = "C-Left";
              "Alt-Right" = "C-Right";
              "Alt-BackSpace" = "C-BackSpace";
              "Alt-Delete" = "C-Delete";

              "Super-BackSpace" = [
                "Shift-Home"
                "Delete"
              ];
              "Super-Delete" = [
                "Shift-End"
                "Delete"
              ];
            };
          }
          {
            name = "Terminals: map Super to Ctrl+Shift (copy/paste, tabs, etc.)";
            application = {
              only = [
                "com.mitchellh.ghostty"
              ];
            };
            exact_match = false;
            remap = {
              "Super-c" = "C-Shift-c";
              "Super-v" = "C-Shift-v";
              "Super-x" = "C-Shift-x";
              "Super-t" = "C-Shift-t";
              "Super-w" = "C-Shift-w";
              "Super-n" = "C-Shift-n";
              "Super-Left" = "Home";
              "Super-Right" = "End";
              "Super-Up" = "C-Home";
              "Super-Down" = "C-End";
              "Alt-Left" = "C-Left";
              "Alt-Right" = "C-Right";
              "Alt-BackSpace" = "C-BackSpace";
              "Alt-Delete" = "C-Delete";
            };
          }
        ];
      };
    };
  };
}
