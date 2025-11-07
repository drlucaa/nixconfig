{
  pkgs,
  username,
  ...
}:
{
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    }
  ];

  home-manager.users.${username} =
    { ... }:
    {
      gtk = {
        enable = true;
        iconTheme = {
          name = "Tela-dark";
          package = pkgs.tela-icon-theme;
        };
        theme = {
          name = "Orchis-Dark";
          package = pkgs.orchis-theme;
        };
        font = {
          name = "Monaspace Neon";
          size = 11;
        };

      };
    };
}
