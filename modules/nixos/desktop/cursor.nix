{
  pkgs,
  username,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop.cursor;
in
{
  options.modules.desktop.cursor.variant = lib.mkOption {
    type = lib.types.enum [
      "bibata"
      "vimix"
    ];
    default = "bibata";
  };

  config = {
    home-manager.users.${username} =
      { ... }:
      {
        home.pointerCursor =
          (
            if cfg.variant == "vimix" then
              {
                name = "Vimix-white-cursors";
                package = pkgs.vimix-cursors;
              }
            else
              {
                name = "Bibata-Modern-Ice";
                package = pkgs.bibata-cursors;
              }
          )
          // {
            size = 16;
            gtk.enable = true;
          };
      };
  };
}
