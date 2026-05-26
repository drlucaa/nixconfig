{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;

    package = pkgs.unstable.zed-editor;

    extensions = [
      "nix"
      "opentofu"
      "java"
      "xml"
    ];

    extraPackages = with pkgs.unstable; [
      nil
      nixd
      tofu-ls
      jdt-language-server
      temurin-bin
      lombok
      google-java-format
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
      ui_font_size = 16;
      buffer_font_size = 16;

      lsp = {
        nil = {
          binary = {
            path = "${pkgs.unstable.nil}/bin/nil";
          };
        };
        nixd = {
          binary = {
            path = "${pkgs.unstable.nixd}/bin/nixd";
          };
        };
        tofu-ls = {
          binary = {
            path = "${pkgs.unstable.tofu-ls}/bin/tofu-ls";
            arguments = [ "serve" ];
          };
        };
        jdtls = {
          settings = {
            java_home = "${pkgs.unstable.temurin-bin}";
            lombok_support = true;
            jdk_auto_download = false;

            check_updates = "never";

            jdtls_launcher = "${pkgs.unstable.jdt-language-server}/bin/jdtls";
            lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
          };
        };
      };
      languages = {
        Java = {
          format_on_save = "off";
        };
      };
    };

    mutableUserKeymaps = false;
    userKeymaps = [
      {
        context = "Editor && vim_mode == helix_insert";
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
        };
      }
    ];
  };
}
