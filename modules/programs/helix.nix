# modules/programs/helix.nix
{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.modules.programs.helix;
in {
  options.modules.programs.helix = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable helix editor";
    };
  };

  config = mkIf cfg.enable {
    # System-wide environment variables for Helix
    environment.variables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    # Home Manager configuration for the user
    home-manager.users.${username} = {pkgs, ...}: {
      home.packages = [pkgs.yazi];

      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "github_dark";

          keys = {
            normal = {
              ret = "goto_word";
              "C-s" = ":write";
              "C-x" = ":reset-diff-change";
              space = {
                q = {
                  q = ":quit-all";
                  s = ":write-quit-all";
                  f = ":quit-all!";
                };

                # Your yazi keybinding
                E = [
                  ":sh rm -f /tmp/unique-file"
                  ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
                  ":insert-output echo \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
                  ":open %sh{cat /tmp/unique-file}"
                  ":redraw"
                ];

                e = "file_explorer_in_current_buffer_directory";

                space = {
                  b = ":sh git blame -L %{cursor_line},%{cursor_line} %{buffer_name}";
                };
              };
            };
            insert = {
              j = {
                j = "normal_mode";
              };
            };
          };

          editor = {
            mouse = false;
            line-number = "relative";
            true-color = true;
            cursorline = true;
            default-yank-register = "+";
            bufferline = "multiple";
            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
            clipboard-provider = "waylnad";

            cursor-shape = {
              normal = "block";
              insert = "bar";
              select = "underline";
            };

            indent-guides = {
              render = true;
              character = "▏";
              skip-levels = 1;
            };

            soft-wrap = {
              enable = true;
              max-wrap = 25;
              max-indent-retain = 0;
              wrap-indicator = "▷ ";
            };

            statusline = {
              left = ["mode" "spinner"];
              center = ["file-name" "file-modification-indicator"];
              right = [
                "diagnostics"
                "version-control"
                "position"
                "file-encoding"
                "file-line-ending"
                "file-type"
              ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };

            lsp = {
              display-inlay-hints = true;
            };
          };
        };

        themes = {
          github_dark = let
            bg = "#0d1117";
            bg_dim = "#010409";
            bg_hover = "#161b22";
            sel = "#3c4a5d";
            fg = "#c9d1d9";
            fg_dim = "#5d626e";
            muted = "#8b949e";
            gutter = "#6e7681";
            ruler = "#484f58";
            blue = "#79c0ff";
            blue_alt = "#a5d6ff";
            purple = "#bc8cff";
            green = "#2ea043";
            green_alt = "#7ee787";
            orange = "#ffa657";
            keyword_red = "#ff7b72";
            error_red = "#ffa198";
            warn_yellow = "#d29922";
            window_edge = "#0d1117";
          in {
            # GENERAL
            "warning" = {fg = warn_yellow;};
            "error" = {fg = error_red;};
            "diagnostic" = {modifiers = ["underlined"];};
            "info" = {fg = blue_alt;};
            "hint" = {fg = green_alt;};

            # UI
            "ui.background" = {
              bg = bg;
              fg = fg;
            };
            "ui.text" = {fg = fg;};
            "ui.help" = {
              bg = bg_dim;
              fg = fg;
            };
            "ui.window" = {fg = window_edge;};
            "ui.popup" = {
              bg = bg_dim;
              fg = fg;
            };
            "ui.menu" = {
              bg = bg_dim;
              fg = fg;
            };
            "ui.menu.selected" = {bg = bg_hover;};
            "ui.statusline" = {fg = fg;};
            "ui.linenr" = {fg = gutter;};
            "ui.linenr.selected" = {fg = fg;};
            "ui.virtual" = {
              fg = fg_dim;
              modifiers = ["bold"];
            };
            "ui.virtual.ruler" = {bg = ruler;};
            "ui.virtual.whitespace" = {fg = ruler;};
            "ui.selection" = {bg = sel;};
            "ui.selection.primary" = {bg = sel;};
            "ui.cursor" = {modifiers = ["reversed"];};
            "ui.cursor.primary" = {modifiers = ["reversed"];};
            "ui.cursor.match" = {
              fg = green;
              modifiers = ["underlined" "bold"];
            };
            "ui.cursorline.primary" = {bg = bg_dim;};

            # SYNTAX HIGHLIGHTING
            "comment" = {
              fg = muted;
              modifiers = ["italic"];
            };
            "constant" = {fg = blue;};
            "constant.character.escape" = {fg = blue_alt;};
            "function" = {fg = purple;};
            "function.macro" = {};
            "keyword" = {fg = keyword_red;};
            "operator" = {fg = blue;};
            "string" = {fg = blue_alt;};
            "string.regexp" = {fg = blue_alt;};
            "type" = {fg = orange;};
            "tag" = {fg = green;};
            "special" = {fg = purple;};

            # MARKUP
            "markup.bold" = {
              fg = fg;
              modifiers = ["bold"];
            };
            "markup.italic" = {
              fg = fg;
              modifiers = ["italic"];
            };
            "markup.heading" = {
              fg = blue;
              modifiers = ["bold"];
            };
            "markup.link" = {
              fg = blue_alt;
              modifiers = ["underline"];
            };
            "markup.quote" = {fg = green_alt;};
            "markup.raw" = {fg = blue;};
          };
        };

        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "nixfmt";
              };
              auto-format = true;
            }
          ];

          grammar = [
            {
              name = "nu";
              source = {
                git = "https://github.com/nushell/tree-sitter-nu";
                rev = "6544c4383643cf8608d50def2247a7af8314e148";
              };
            }
          ];
        };
      };
    };
  };
}
