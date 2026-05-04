{
  pkgs,
  hostname,
  ...
}:
{
  programs.fish = {
    enable = true;
    generateCompletions = true;

    interactiveShellInit = ''
      fastfetch

      # Workaround for Fish 4.3.0+ breaking Tide vi-mode detection
      set -g fish_key_bindings fish_hybrid_key_bindings
      set -g tide_character_vi_icon_default '❯'
    '';

    shellAbbrs = {
      c = "clear";
      mkdir = "mkdir -p";
      rd = "rm -rf";

      ff = "flux9s";

      # nix
      nrs = "sudo env NIX_CONFIG=\"access-tokens = github.com=$(gh auth token)\" darwin-rebuild switch --flake ~/nixconfig#${hostname}";
      ngc = "sudo nix-collect-garbage -d";
      nd = "nix develop";
    };

    shellAliases = {
    };

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
    ];

    functions = {
      fish_greeting = "";
      cx = "mkdir -p $argv && cd $argv";
      flake-init = ''
        echo "use flake" > .envrc
        direnv allow
      '';
      _tide_item_node = ''
        if command -sq node
            node --version | string match -qr "v(?<v>.*)"
            _tide_print_item node $tide_node_icon' ' "$v"
        else if command -sq bun
            bun --version | string match -qr "(?<v>.*)"
            _tide_print_item node $tide_node_icon' ' "bun $v"
        end
      '';
      _tide_item_git = ''
        # Try jj first; if that fails, fall back to fish's normal git prompt.
        fish_jj_prompt; or fish_git_prompt
      '';
      fish_jj_prompt = ''
        # If jj isn't installed, there's nothing we can do
        # Return 1 so the calling prompt can deal with it
        if not command -sq jj
            return 1
        end
        set -l info "$(
            jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @ \
                --template '
                    surround(
                        "(",
                        ")",
                        separate(
                            " ",
                            bookmarks.join(", "),
                            change_id.shortest(),
                            commit_id.shortest(),
                            if(conflict, label("conflict", "×")),
                            if(divergent, label("divergent", "??")),
                            if(hidden, label("hidden prefix", "(hidden)")),
                            if(immutable, label("node immutable", "◆")),
                            coalesce(
                                if(
                                    empty,
                                    coalesce(
                                        if(
                                            parents.len() > 1,
                                            label("empty", "(merged)"),
                                        ),
                                        label("empty", "(empty)"),
                                    ),
                                ),
                                label("description placeholder", "*")
                            ),
                        )
                    )
                '
        )"
        or return 1
        if test -n "$info"
            printf ' %s' $info
        end
      '';
    };
  };
}
