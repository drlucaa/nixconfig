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
      # dconf.settings = {
      #   "org/gnome/desktop/interface" = {
      #     color-scheme = "prefer-dark";
      #   };
      # };

      gtk = {
        enable = true;
        iconTheme.name = "Papirus-Dark";
        iconTheme.package = pkgs.papirus-icon-theme;
        theme.name = "orchis-Dark";
        theme.package = pkgs.orchis-theme;
      };
    };
}
