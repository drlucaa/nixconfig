{
  username,
  ...
}:
{
  config = {
    # System-wide environment variables for Helix
    environment.variables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    # Home Manager configuration for the user
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = with pkgs.unstable; [
          yazi
          vscode-langservers-extracted
          delve
          gopls
          helm-ls
          prettier
          superhtml
          taplo
          templ
          yaml-language-server
          docker-language-server
          markdown-oxide
          deno
        ];

        programs.helix = {
          enable = true;
          defaultEditor = true;
          package = pkgs.unstable.helix;
          settings = {
            keys = {
              normal = {
                ret = "goto_word";
                p = "paste_before";
                P = "paste_after";
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

              clipboard-provider =
                if pkgs.stdenv.hostPlatform.isLinux then
                  "wayland"
                else if pkgs.stdenv.hostPlatform.isDarwin then
                  "pasteboard"
                else
                  "none";

              completion-trigger-len = 1;
              completion-timeout = 5;
              completion-replace = true;

              file-picker.hidden = false;

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

              whitespace.render = {
                space = "none";
                tab = "none";
                nbsp = "none";
                nnbsp = "none";
                newline = "all";
              };

              soft-wrap = {
                enable = true;
                max-wrap = 25;
                max-indent-retain = 0;
                wrap-indicator = "▷ ";
              };

              statusline = {
                left = [
                  "mode"
                  "spinner"
                ];
                center = [
                  "file-name"
                  "file-modification-indicator"
                ];
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

          languages = {
            language = [
              {
                name = "nix";
                formatter = {
                  command = "nixfmt";
                };
                auto-format = true;
              }
              {
                name = "markdown";
                auto-format = true;
                formatter = {
                  command = "deno";
                  args = [
                    "fmt"
                    "-"
                    "--ext"
                    "md"
                  ];
                };
              }
            ];
          };
        };
      };
  };
}
