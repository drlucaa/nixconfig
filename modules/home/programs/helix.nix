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
          "C-," = [
            "normal_mode"
            "goto_line_end"
            ":append-output echo -n ','"
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
          "C-," = [
            "normal_mode"
            "goto_line_end"
            ":append-output echo -n ','"
            "move_char_right"
            "insert_mode"
          ];
          "C-l" = [
            "normal_mode"
            "move_char_right"
            "insert_mode"
          ];
          "C-o" = [
            "normal_mode"
            "move_char_right"
            "open_below"
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
          display-inlay-hints = false;
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
      "*.lock"
    ];

    extraPackages = with pkgs; [
      # --- General / Multi-language ---
      simple-completion-language-server
      deps-lsp
      vscode-langservers-extracted # Provides HTML, CSS, JSON, ESLint
      prettier
      xmlstarlet

      # --- Nix ---
      nixd
      nixfmt-rfc-style

      # --- Nickel ---
      pkgs.unstable.nls

      # --- Go ---
      gopls
      gofumpt
      delve

      # --- Rust ---
      inputs.fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.toolchain

      # --- Java ---
      jdt-language-server
      lombok

      # --- Just ---
      pkgs.unstable.just-lsp

      # --- KDL ---
      kdlfmt

      # --- Web / Frontend ---
      superhtml
      tailwindcss-language-server
      typescript-language-server
      svelte-language-server
      typescript

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

      # --- Starlark ---
      starpls
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
        deps-lsp = {
          command = "deps-lsp";
          args = [ "--stdio" ];
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
            "--jvm-arg=-Xms256m"
            "--jvm-arg=-Xmx2G"

            # Optimize for Throughput and Fast Indexing
            "--jvm-arg=-XX:+UseParallelGC"
            "--jvm-arg=-XX:+DisableExplicitGC"

            # Startup Speed Tweaks
            "--jvm-arg=-Xshare:auto"
            "--jvm-arg=-XX:+UsePerfData"
          ];

        };
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            checkOnSave = true;
            check.command = "clippy";
            cargo.allFeatures = true;
            procMacro.enable = true;
          };
        };
        tailwind = {
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
          root-pattern = [
            "flake.nix"
            "package.json"
          ];
          config = {
            tailwindCSS = {
              includeLanguages = {
                svelte = "html";
              };
            };
          };
        };
        scls = {
          command = "simple-completion-language-server";
          config = {
            feature_words = true;
            feature_snippets = true;
            snippets_first = true;
            snippets_inline_by_word_tail = true;
            feature_unicode_input = false;
            feature_paths = false;
          };
        };
        vscode-css-language-server = {
          config = {
            css = {
              lint = {
                unknownAtRules = "ignore";
              };
            };
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
          formatter = {
            command = "gofumpt";
          };
        }
        {
          name = "xml";
          auto-format = true;
          formatter = {
            command = "xmlstarlet";
            args = [ "fo" ];
          };
        }
        {
          name = "kdl";
          auto-format = true;
          formatter = {
            command = "kdlfmt";
            args = [
              "format"
              "-"
            ];
          };
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
            "tailwind"
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
            "deps-lsp"
          ];
          auto-format = true;
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
            "tailwindcss-language-server"
            "vscode-css-language-server"
          ];
        }
        {
          name = "html";
          language-servers = [
            "scls"
            "tailwind"
            "superhtml"
          ];
          formatter = {
            command = "deno";
            args = [
              "fmt"
              "-"
            ];
          };
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = [
            "scls"
            "tailwind"
            "svelteserver"
          ];
          formatter = {
            command = "deno";
            args = [
              "fmt"
              "-"
              "--ext"
              "svelte"
              "--unstable-component"
            ];
          };
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            "scls"
            "typescript-language-server"
          ];
          formatter = {
            command = "deno";
            args = [
              "fmt"
              "-"
            ];
          };
        }
        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            "scls"
            "typescript-language-server"
          ];
          formatter = {
            command = "deno";
            args = [
              "fmt"
              "-"
            ];
          };
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
            "tailwind"
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
        {
          name = "git-commit";
          language-servers = [ "scls" ];
        }
        {
          name = "xml";
          language-servers = [
            "scls"
            "deps-lsp"
          ];
        }
        {
          name = "json";
          language-servers = [
            "scls"
            "deps-lsp"
            "vscode-json-language-server"
          ];
        }
        {
          name = "env";
          language-servers = [ "scls" ];
        }
        {
          name = "just";
          language-servers = [
            "sclc"
            "just-lsp"
          ];
        }
        {
          name = "jjdescription";
          language-servers = [
            "scls"
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
