{
  pkgs,
  inputs,
  username,
  ...
}:
{
  # Enable essential services for a graphical session
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  # Required for authentication in graphical applications
  systemd = {
    user.services = {
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };
      };
    };
  };

  # XDG portals for application integration (e.g., file pickers)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Niri-specific overlay for packages
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  # Environment variables for Wayland compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # A minimal set of packages
  environment.systemPackages = with pkgs; [
    kitty # A terminal is essential
  ];

  # Enable Niri and XWayland
  programs = {
    niri.enable = true;
    dconf.enable = true;
    xwayland.enable = true;
  };

  # Minimal Home Manager configuration for Niri
  home-manager.users.${username} =
    {
      config,
      ...
    }:
    {
      programs.niri = {
        settings = {
          # A few essential environment variables
          environment = {
            GDK_BACKEND = "wayland,x11";
            QT_QPA_PLATFORMTHEME = "gtk3";
          };

          # Minimal keybindings for basic usability
          binds =
            with config.lib.niri.actions;
            {
              # Focus movement
              "Alt+Right".action = focus-column-or-monitor-right;
              "Alt+Left".action = focus-column-or-monitor-left;
              "Alt+Up".action = focus-window-or-workspace-up;
              "Alt+Down".action = focus-window-or-workspace-down;

              # Window movement
              "Ctrl+Alt+Right".action = consume-or-expel-window-right;
              "Ctrl+Alt+Left".action = consume-or-expel-window-left;
              "Ctrl+Alt+Up".action = move-window-up-or-to-workspace-up;
              "Ctrl+Alt+Down".action = move-window-down-or-to-workspace-down;

              # Workspace switching
              "Alt+1".action = focus-workspace 1;
              "Alt+2".action = focus-workspace 2;
              "Alt+3".action = focus-workspace 3;
              "Alt+4".action = focus-workspace 4;
              "Alt+5".action = focus-workspace 5;

              # Essential actions
              "Super+X".action = close-window;
              "Super+T".action = spawn "kitty"; # Launch terminal
            };
        };
      };
    };
}
