{
  pkgs,
  lib,
  inputs,
  username,
  ...
}:
{
  # Enable essential services for a graphical session
  services = {
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
      xdg-desktop-portal-gnome
    ];
  };

  # Niri-specific overlay for packages
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  niri-flake.cache.enable = false;

  # Environment variables for Wayland compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # A minimal set of packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  # Enable Niri and XWayland
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };

    dconf.enable = true;
    ssh.askPassword = "";
    xwayland.enable = true;
  };

  # Minimal Home Manager configuration for Niri
  home-manager.users.${username} =
    { config, ... }:
    {
      programs.niri = {
        settings = {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;
          screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          # A few essential environment variables
          environment = {
            GDK_BACKEND = "wayland,x11";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            SDL_VIDEODRIVER = "wayland,x11";
            CLUTTER_BACKEND = "wayland";
          };

          spawn-at-startup = [
            { sh = "systemctl --user restart walker"; }
            { sh = "systemctl --user restart wpaperd"; }
            { sh = "systemctl --user restart xremap"; }
            { sh = "systemctl --user restart quickshell"; }
          ];

          input = {
            warp-mouse-to-focus.enable = true;
            mod-key = "Alt";
          };

          gestures.hot-corners.enable = false;

          # Minimal keybindings for basic usability
          binds = with config.lib.niri.actions; {
            # Essential actions
            "Super+Q".action = close-window;
            "Super+Space".action = spawn "walker";

            "Mod+T".action = spawn "ghostty";
            "Mod+B".action = spawn "zen";
            "Mod+Shift+W".action = spawn-sh "wpaperctl next";

            # Focus movement
            "Mod+Ctrl+H".action = focus-monitor-left;
            "Mod+Ctrl+J".action = focus-monitor-down;
            "Mod+Ctrl+K".action = focus-monitor-up;
            "Mod+Ctrl+L".action = focus-monitor-right;
            "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

            # Window movement
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;
            "Mod+Shift+H".action = move-column-left;
            "Mod+Shift+J".action = move-window-down;
            "Mod+Shift+K".action = move-window-up;
            "Mod+Shift+L".action = move-column-right;
            "Mod+Home".action = focus-column-first;
            # "Mod+End ".action = focus-column-last;
            "Mod+Ctrl+Home".action = move-column-to-first;
            # "Mod+Ctrl+End ".action = move-column-to-last;

            # Workspace switching
            "Mod+U".action = focus-workspace-down;
            "Mod+I".action = focus-workspace-up;
            "Mod+Ctrl+U".action = move-workspace-down;
            "Mod+Ctrl+I".action = move-workspace-up;
            "Mod+Shift+U".action = move-column-to-workspace-down;
            "Mod+Shift+I".action = move-column-to-workspace-up;
            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;

            # Overview
            "Mod+o".action = toggle-overview;

            # Resize window
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";

            # Screenshot
            # "Print".action = screenshot;

            # Others
            "Mod+Comma".action = consume-window-into-column;
            "Mod+Period".action = expel-window-from-column;
            "Mod+BracketLeft".action = consume-or-expel-window-left;
            "Mod+BracketRight".action = consume-or-expel-window-right;
            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = reset-window-height;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+C".action = center-column;
            "Mod+Ctrl+F".action = toggle-window-floating;
            "Mod+V".action = toggle-column-tabbed-display;

            "Mod+Shift+Q".action = quit;
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+Shift+P".action = power-off-monitors;
          };

          layout = {
            gaps = 5;
            center-focused-column = "never";
            always-center-single-column = true;
            default-column-width = { };

            focus-ring.enable = false;
            border = {
              enable = true;
              width = 2;
              active.color = "#798ebd";
              inactive.color = "#665c54";
            };
          };

          window-rules = [
            {
              geometry-corner-radius =
                let
                  radius = 8.0;
                in
                {
                  bottom-left = radius;
                  bottom-right = radius;
                  top-left = radius;
                  top-right = radius;
                };
              clip-to-geometry = true;
              draw-border-with-background = false;
            }
            {
              excludes = [
                { app-id = "zen"; }
              ];
              opacity = 0.98;
            }
            {
              matches = [
                { app-id = "spotify"; }
              ];

              default-column-width.proportion = 0.8;
            }
          ];
        };
      };
    };
}
