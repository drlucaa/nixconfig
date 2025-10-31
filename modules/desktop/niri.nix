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
    ];
  };

  # Niri-specific overlay for packages
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  # Environment variables for Wayland compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # A minimal set of packages
  environment.systemPackages = with pkgs; [
    kitty # A terminal is essential
    wl-clipboard
    jjui
    firefox
    gemini-cli
    bluetui
    impala
  ];

  # Enable Niri and XWayland
  programs = {
    niri.enable = true;
    dconf.enable = true;
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
            QT_QPA_PLATFORMTHEME = "gtk3";
          };

          spawn-at-startup =
            let
              sh = [
                "sh"
                "-c"
              ];
            in
            [
              { command = sh ++ [ "systemctl --user start walker.service" ]; }
            ];

          input = {
            warp-mouse-to-focus.enable = true;
          };

          gestures.hot-corners.enable = false;

          # Minimal keybindings for basic usability
          binds = with config.lib.niri.actions; {
            # Essential actions
            "Super+Q".action = close-window;
            "Super+T".action = spawn "ghostty";
            "Super+Space".action = spawn "walker";

            # Focus movement
            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+J".action = focus-monitor-down;
            "Mod+Shift+K".action = focus-monitor-up;
            "Mod+Shift+L".action = focus-monitor-right;
            "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

            # Window movement
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+L".action = move-column-right;
            "Mod+Home".action = focus-column-first;
            # "Mod+End ".action = focus-column-last;
            "Mod+Ctrl+Home".action = move-column-to-first;
            # "Mod+Ctrl+End ".action = move-column-to-last;

            # Workspace switching
            "Mod+U".action = focus-workspace-down;
            "Mod+I".action = focus-workspace-up;
            "Mod+Shift+U".action = move-workspace-down;
            "Mod+Shift+I".action = move-workspace-up;
            "Mod+Ctrl+U".action = move-column-to-workspace-down;
            "Mod+Ctrl+I".action = move-column-to-workspace-up;
            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;

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
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = reset-window-height;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+C".action = center-column;
            "Mod+W".action = toggle-window-floating;
            "Mod+V".action = toggle-column-tabbed-display;
          };

          layout = {
            gaps = 10;
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
          ];
        };
      };
    };
}
