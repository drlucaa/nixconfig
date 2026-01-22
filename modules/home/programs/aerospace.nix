{
  username,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    home-manager.users.${username} = {
      xdg.configFile."aerospace/aerospace.toml".text = ''
        after-startup-command = [
          'exec-and-forget borders active_color=0xffa3abad inactive_color=0xff494d64 width=5.0'
        ]

        start-at-login = true

        enable-normalization-flatten-containers = true
        enable-normalization-opposite-orientation-for-nested-containers = true

        accordion-padding = 15

        default-root-container-layout = 'accordion'

        default-root-container-orientation = 'auto'

        on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
        # on-focus-changed = ['move-mouse window-lazy-center']

        automatically-unhide-macos-hidden-apps = true

        [[on-window-detected]]
        if.app-id = 'com.apple.finder'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.electron.dockerdesktop'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'net.whatsapp.WhatsApp'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.1password.1password'
        run = 'layout floating'

        [key-mapping]
        preset = 'qwerty'

        [gaps]
        inner.horizontal = 10
        inner.vertical = 10
        outer.left = 5
        outer.bottom = 5
        outer.top = 5
        outer.right = 5

        [mode.main.binding]

        alt-slash = 'layout tiles horizontal vertical'
        alt-comma = 'layout accordion horizontal vertical'

        alt-h = 'focus left'
        alt-j = 'focus down'
        alt-k = 'focus up'
        alt-l = 'focus right'

        alt-shift-h = 'move left'
        alt-shift-j = 'move down'
        alt-shift-k = 'move up'
        alt-shift-l = 'move right'

        alt-minus = 'resize smart -50'
        alt-equal = 'resize smart +50'

        alt-1 = 'workspace 1'
        alt-2 = 'workspace 2'
        alt-3 = 'workspace 3'
        alt-4 = 'workspace 4'
        alt-5 = 'workspace 5'
        alt-6 = 'workspace 6'
        alt-7 = 'workspace 7'
        alt-8 = 'workspace 8'
        alt-9 = 'workspace 9'

        alt-shift-1 = ['move-node-to-workspace 1']
        alt-shift-2 = ['move-node-to-workspace 2']
        alt-shift-3 = ['move-node-to-workspace 3']
        alt-shift-4 = ['move-node-to-workspace 4']
        alt-shift-5 = ['move-node-to-workspace 5']
        alt-shift-6 = ['move-node-to-workspace 6']
        alt-shift-7 = ['move-node-to-workspace 7']
        alt-shift-8 = ['move-node-to-workspace 8']
        alt-shift-9 = ['move-node-to-workspace 9']

        alt-shift-f = 'fullscreen'

        alt-f = 'exec-and-forget open -a /System/Library/CoreServices/Finder.app'
        alt-b = 'exec-and-forget open -a /Applications/Arc.app'
        alt-e = 'exec-and-forget open -a /Applications/Zed.app'
        alt-t = 'exec-and-forget open -a ${pkgs.unstable.ghostty-bin}/Applications/Ghostty.app'
        alt-p = 'exec-and-forget open -a /Applications/Linear.app'

        alt-tab = 'workspace-back-and-forth'
        alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

        alt-shift-semicolon = 'mode service'

        cmd-h = []     # Disable "hide application"
        cmd-alt-h = [] # Disable "hide others"

        [mode.service.binding]
        esc = ['reload-config', 'mode main']
        r = ['flatten-workspace-tree', 'mode main'] # reset layout
        f = [
          'layout floating tiling',
          'mode main',
        ] # Toggle between floating and tiling layout
        backspace = ['close-all-windows-but-current', 'mode main']

        # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
        #s = ['layout sticky tiling', 'mode main']

        alt-shift-h = ['join-with left', 'mode main']
        alt-shift-j = ['join-with down', 'mode main']
        alt-shift-k = ['join-with up', 'mode main']
        alt-shift-l = ['join-with right', 'mode main']

        down = 'volume down'
        up = 'volume up'
        shift-down = ['volume set 0', 'mode main']
                
      '';
    };
  };
}
