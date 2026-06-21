{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;

    package = pkgs.zed-editor;

    extensions = [
      "nix"
      "opentofu"
      "java"
      "just"
      "xml"
      "toml"
      "tombi"
      "dockerfile"
      "git-firefly"
      "ansible"
      "gitlab-ci-ls"
      "helm"
    ];

    extraPackages = with pkgs; [
      nil
      nixd
      tofu-ls
      jdt-language-server
      temurin-bin
      lombok
      google-java-format
      just-lsp
      tombi
      dockerfile-language-server
      ansible-language-server
      ansible
      ansible-lint
      yaml-language-server
      gitlab-ci-ls
      helm-ls
    ];

    mutableUserSettings = false;
    userSettings = {
      show_whitespaces = "boundary";
      completion_menu_item_kind = "symbol";
      completions = {
        words_min_length = 1;
      };
      disable_ai = true;
      project_panel = {
        dock = "left";
      };
      outline_panel = {
        dock = "left";
      };
      collaboration_panel = {
        dock = "left";
      };
      git_panel = {
        dock = "left";
      };
      which_key = {
        enabled = true;
        delay_ms = 100;
      };
      relative_line_numbers = "enabled";
      helix_mode = true;
      ui_font_size = 14;
      buffer_font_size = 14;

      lsp = {
        nil = {
          binary = {
            path = "${pkgs.nil}/bin/nil";
          };
        };
        nixd = {
          binary = {
            path = "${pkgs.nixd}/bin/nixd";
          };
        };
        tofu-ls = {
          binary = {
            path = "${pkgs.tofu-ls}/bin/tofu-ls";
            arguments = [ "serve" ];
          };
        };
        jdtls = {
          settings = {
            java_home = "${pkgs.temurin-bin}";
            lombok_support = true;
            jdk_auto_download = false;

            check_updates = "never";

            jdtls_launcher = "${pkgs.jdt-language-server}/bin/jdtls";
            lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
          };
          # maybe remove as settings would probably be better
          initialization_options = {
            settings = {
              java = {
                saveActions = {
                  organizeImports = false;
                };
                format = {
                  enabled = false;
                };
              };
            };
          };
        };
        just-lsp = {
          binary = {
            path = "${pkgs.just-lsp}/bin/just-lsp";
          };
        };
        tombi = {
          binary = {
            path = "${pkgs.tombi}/bin/tombi";
            arguments = [ "lsp" ];
          };
        };
        dockerfile-language-server = {
          binary = {
            path = "${pkgs.dockerfile-language-server}/bin/docker-langserver";
            arguments = [ "--stdio" ];
          };
        };
        ansible = {
          binary = {
            path = "${pkgs.ansible-language-server}/bin/ansible-language-server";
            arguments = [ "--stdio" ];
          };
          settings = {
            ansible = {
              path = "${pkgs.ansible}/bin/ansible";
            };
            validation = {
              enabled = true;
              lint = {
                enabled = true;
                path = "${pkgs.ansible-lint}/bin/ansible-lint";
              };
            };
          };
        };
        yaml-language-server = {
          binary = {
            path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
            arguments = [
              "--stdio"
            ];
          };
          settings = {
            yaml = {
              schemaStore = {
                enable = true;
              };
              kubernetesCRDStore = {
                enable = true;
              };

              schemas = {
                kubernetes = [
                  "/*.k8s.yaml"
                  "/*.k8s.yml"
                  "/*.kube.yaml"
                  "/*.kube.yml"
                  "/k8s/**/*.yaml"
                  "/k8s/**/*.yml"
                  "/kubernetes/**/*.yaml"
                  "/kubernetes/**/*.yml"
                  "/manifests/**/*.yaml"
                  "/manifests/**/*.yml"
                  "/deploy/**/*.yaml"
                  "/deploy/**/*.yml"
                  "/deployments/**/*.yaml"
                  "/deployments/**/*.yml"
                ];

                "https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/kustomization.json" =
                  [
                    "/kustomization.yaml"
                    "/kustomization.yml"
                    "/**/kustomization.yaml"
                    "/**/kustomization.yml"
                  ];

                "https://json.schemastore.org/chart.json" = [
                  "/Chart.yaml"
                  "/**/Chart.yaml"
                ];
              };
            };
          };
        };
        gitlab-ci = {
          binary = {
            path = "${pkgs.gitlab-ci-ls}/bin/gitlab-ci-ls";
          };
        };
        helm_ls = {
          binary = {
            path = "${pkgs.helm-ls}/bin/helm-ls";
          };
          settings = {
            helm-ls = {
              yamlls = {
                path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
              };
            };
          };
        };
      };
      languages = {
        Java = {
          format_on_save = "off";
        };
      };
      file_types = {
        "Ansible" = [
          "**.ansible.yml"
          "**.ansible.yaml"
          "**/defaults/*.yml"
          "**/defaults/*.yaml"
          "**/meta/*.yml"
          "**/meta/*.yaml"
          "**/tasks/*.yml"

          "**/handlers/*.yml"
          "**/handlers/*.yaml"
          "**/group_vars/*.yml"
          "**/group_vars/*.yaml"
          "**/playbooks/*.yaml"
          "**/playbooks/*.yml"
          "**playbook*.yaml"
          "**playbook*.yml"
        ];
      };
    };

    mutableUserKeymaps = false;
    userKeymaps = [
      {
        context = "Editor && vim_mode == insert";
        bindings = {
          "j j" = [
            "workspace::SendKeystrokes"
            "escape"
          ];
          "j k" = [
            "workspace::SendKeystrokes"
            "escape"
          ];
        };
      }
      {
        context = "(vim_mode == helix_normal || vim_mode == helix_select) && !menu";
        bindings = {
          "enter" = "vim::HelixJumpToWord";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "f" = "project_panel::NewFile";
          "y" = "project_panel::Copy";
          "p" = "project_panel::Paste";
          "x" = "project_panel::Cut";
          "enter" = "project_panel::Open";
          "o" = "project_panel::OpenPermanent";
          "v" = "project_panel::OpenSplitVertical";
          "h" = "project_panel::OpenSplitHorizontal";
          "shift-f" = "project_panel::RevealInFileManager";
          "shift-t" = "workspace::OpenInTerminal";
        };
      }
    ];
  };

  programs.fish.shellAliases = {
    zed = "zeditor";
  };
}
