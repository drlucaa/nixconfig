{
  pkgs,
  lib,
  inputs,
  ...
}:
{
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
          "C-h" = ":toggle lsp.display-inlay-hints";
          "C-;" = [
            "normal_mode"
            "goto_line_end"
            ":append-output echo -n ';'"
          ];
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
          "C-;" = [
            "normal_mode"
            "goto_line_end"
            ":append-output echo -n ';'"
            "move_char_right"
            "insert_mode"
          ];
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
          display-inlay-hints = true;
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
      "target"
    ];

    extraPackages = with pkgs; [
      # --- General / Multi-language ---
      simple-completion-language-server
      vscode-langservers-extracted # Provides HTML, CSS, JSON, ESLint
      prettier

      # --- Nix ---
      nixd
      nixfmt-rfc-style

      # --- Go ---
      gopls
      delve
      templ

      # --- Rust ---
      inputs.fenix.packages.${pkgs.system}.stable.toolchain

      # --- Java ---
      jdt-language-server
      lombok

      # --- Web / Frontend ---
      superhtml

      # --- Infrastructure / DevOps ---
      docker-language-server
      helm-ls
      terraform-ls
      terraform

      # --- Configuration (YAML, TOML) ---
      yaml-language-server
      yaml-schema-router
      taplo

      # --- Markdown ---
      markdown-oxide
      deno # Used for markdown formatting

      # --- Typst ---
      tinymist
      typstyle

      # --- Shell ---
      fish-lsp
      bash-language-server
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
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            checkOnSave = true;
            cargo.allFeatures = true;
            procMacro.enable = true;
          };
        };
        scls = {
          command = "simple-completion-language-server";
          config = {
            feature_words = true;
            feature_snippets = true;
            snippets_first = true; # Return snippets before word completions
            snippets_inline_by_word_tail = false; # Suggest snippets by word tail
            feature_unicode_input = true; # Enable unicode input (e.g. alpha -> α)
            feature_paths = true; # Enable path completion
          };
        };
      };

      language = [
        {
          name = "go";
          auto-format = true;
          language-servers = [
            "scls"
            "gopls"
          ];
        }
        {
          name = "yaml";
          language-servers = [
            "scls"
            "yaml-language-server"
          ];
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
          language-servers = [
            "scls"
            "nixd"
          ];
          formatter = {
            command = "nixfmt";
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [
            "scls"
            "markdown-oxide"
          ];
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
          name = "rust";
          auto-format = true;
          language-servers = [
            "scls"
            "rust-analyzer"
          ];
          formatter = {
            command = "rustfmt";
          };
        }
        {
          name = "typst";
          scope = "source.typst";
          injection-regex = "typst";
          file-types = [ "typ" ];
          roots = [ "typst.toml" ];
          language-servers = [
            "scls"
            "tinymist"
          ];
          formatter = {
            command = "typstyle";
          };
          auto-format = true;
        }
        {
          name = "java";
          language-servers = [
            "scls"
            "jdtls"
          ];
        }
        {
          name = "toml";
          language-servers = [
            "scls"
            "taplo"
          ];
        }
        {
          name = "dockerfile";
          language-servers = [
            "scls"
            "docker-langserver"
          ];
        }
        {
          name = "hcl";
          auto-format = true;
          formatter = {
            command = "terraform";
            args = [
              "fmt"
              "-"
            ];
          };
          language-servers = [
            "scls"
            "terraform-ls"
          ];
        }
        {
          name = "json";
          language-servers = [
            "scls"
            "vscode-json-language-server"
          ];
        }
        {
          name = "css";
          language-servers = [
            "scls"
            "vscode-css-language-server"
          ];
        }
        {
          name = "html";
          language-servers = [
            "scls"
            "superhtml"
          ];
        }
        {
          name = "helm";
          language-servers = [
            "scls"
            "helm_ls"
          ];
        }
        {
          name = "templ";
          language-servers = [
            "scls"
            "templ"
          ];
        }
        {
          name = "bash";
          language-servers = [
            "scls"
            "bash-language-server"
          ];
        }
        {
          name = "fish";
          language-servers = [
            "scls"
            "fish-lsp"
          ];
        }
      ];
    };
  };

  xdg.configFile."helix" = {
    source = ../../../config/helix;
    recursive = true;
  };
  home.activation.fetchSclsSnippets = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.git}/bin:$PATH"
    $DRY_RUN_CMD ${pkgs.simple-completion-language-server}/bin/simple-completion-language-server fetch-external-snippets
  '';
}
