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
        programs.helix = {
          enable = true;
          defaultEditor = true;
          package = pkgs.unstable.helix;
          extraPackages = with pkgs; [
            yazi
            vscode-langservers-extracted
            delve
            gopls
            helm-ls
            prettier
            superhtml
            taplo
            templ
            docker-language-server
            markdown-oxide
            deno
            tinymist
            typstyle
            terraform-ls
            yaml-language-server
            yaml-schema-router
            jdt-language-server
            lombok
          ];
          settings = {
            keys = {
              normal = {
                ret = "goto_word";
                p = "paste_before";
                P = "paste_after";
                "C-s" = ":write";
                "C-x" = ":reset-diff-change";
                "C-h" = ":toggle lsp.display-inlay-hints";
                space = {
                  q = {
                    q = ":quit-all";
                    s = ":write-quit-all";
                    f = ":quit-all!";
                  };

                  b = {
                    f = "buffer_picker";
                    q = ":buffer-close";
                    o = ":buffer-close-others";
                    s = ":write-buffer-close";
                  };

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

              clipboard-provider = "pasteboard";

              completion-trigger-len = 1;
              completion-timeout = 5;
              completion-replace = true;

              file-picker = {
                hidden = false;
                git-ignore = false;
              };

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
                display-progress-messages = true;
              };
            };
          };

          ignores = [
            ".direnv"
            "node_modules"
            "vendor"
            ".DS_Store"
            ".idea"
            ".vscode"
          ];

          languages = {
            language-server = {
              tinymist = {
                command = "tinymist";
                config = {
                  exportPdf = "onType";
                  outputPath = "$root/target/$dir/$name";
                };
              };
              yaml-language-server = {
                command = "${pkgs.yaml-schema-router}/bin/yaml-schema-router";
                args = [
                  "--lsp-path"
                  "${pkgs.yaml-language-server}/bin/yaml-language-server"
                ];
              };
              jdtls = {
                command = "jdtls";
                args = [
                  "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"

                  # Increase memory allocation
                  "--jvm-arg=-Xms1G"
                  "--jvm-arg=-Xmx4G"

                  # Optimize Garbage Collection
                  "--jvm-arg=-XX:+UseZGC"
                  "--jvm-arg=-XX:+ZGenerational"
                  "--jvm-arg=-XX:+UseStringDeduplication"

                  # Prevent the JVM from swapping to disk
                  "--jvm-arg=-XX:+AlwaysPreTouch"
                ];
              };
            };

            language = [
              {
                name = "yaml";
                language-servers = [ "yaml-language-server" ];
                formatter = {
                  command = "prettier";
                  args = [
                    "--parser"
                    "yaml"
                  ];
                };
                auto-format = true;
              }
              {
                name = "nix";
                formatter = {
                  command = "nixfmt";
                };
                auto-format = true;
              }
              {
                name = "markdown";
                formatter = {
                  command = "deno";
                  args = [
                    "fmt"
                    "-"
                    "--ext"
                    "md"
                  ];
                };
                auto-format = true;
              }
              {
                name = "typst";
                scope = "source.typst";
                injection-regex = "typst";
                file-types = [ "typ" ];
                roots = [ "typst.toml" ];
                language-servers = [ "tinymist" ];
                formatter = {
                  command = "typstyle";
                };
                auto-format = true;
              }
            ];
          };
        };
      };
  };
}
