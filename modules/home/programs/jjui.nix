{
  pkgs,
  ...
}:
let
  themeDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/jjui/themes"
    else
      ".config/jjui/themes";
in
{
  programs.jjui = {
    enable = true;
    package = pkgs.unstable.jjui;

    settings = {
      ui.theme = "base24-catppuccin-mocha";
    };
  };

  home.file."${themeDir}/base24-catppuccin-mocha.toml".text = ''
    # --- Base & General ---
        "text"     = { fg = "#cdd6f4", bg = "#1e1e2e" }
        "dimmed"   = { fg = "#7f849c", bg = "#1e1e2e" }
        "title"    = { fg = "#cdd6f4", bold = true }
        "shortcut" = { fg = "#f5e0dc" }
        "matched"  = { fg = "#94e2d5" }
        "border"   = { fg = "#6c7086" }
        "selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        # --- Global Markers & States ---
        "source_marker" = { bg = "#f5c2e7", fg = "#1e1e2e", bold = true }
        "target_marker" = { bg = "#fab387", fg = "#1e1e2e", bold = true }
        "success"       = { fg = "#a6e3a1", bold = true }
        "error"         = { fg = "#f38ba8", bold = true }

        # --- Status Panel ---
        "status"          = { bg = "#181825" }
        "status title"    = { fg = "#1e1e2e", bg = "#89b4fa", bold = true }
        "status shortcut" = { fg = "#f5e0dc" }
        "status dimmed"   = { fg = "#7f849c" }

        # --- Revset Input ---
        "revset title"               = { fg = "#cdd6f4", bold = true }
        "revset text"                = { fg = "#cdd6f4", bold = true }
        "revset completion text"     = { fg = "#cdd6f4" }
        "revset completion matched"  = { fg = "#94e2d5", bold = true }
        "revset completion dimmed"   = { fg = "#7f849c" }
        "revset completion selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        # --- Revisions & Logs ---
        "revisions"                      = { fg = "#cdd6f4" }
        "revisions selected"             = { bg = "#313244", fg = "#cdd6f4", bold = true }
        "revisions dimmed"               = { fg = "#7f849c" }
        "revisions details selected"     = { bg = "#313244", bold = true }
        "revisions details added"        = { fg = "#a6e3a1" }
        "revisions details modified"     = { fg = "#89b4fa" }
        "revisions details deleted"      = { fg = "#f38ba8" }
        "revisions details renamed"      = { fg = "#fab387" }
        "revisions rebase source_marker" = { bold = true }
        "revisions rebase target_marker" = { bold = true }

        "oplog selected"  = { bg = "#313244", fg = "#cdd6f4", bold = true }
        "evolog"          = { fg = "#cdd6f4" }
        "evolog selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        # --- Floating Menus & Panels ---
        "menu"          = { bg = "#1e1e2e" }
        "menu title"    = { fg = "#cdd6f4", bold = true }
        "menu shortcut" = { fg = "#f5e0dc" }
        "menu matched"  = { fg = "#94e2d5", bold = true }
        "menu dimmed"   = { fg = "#7f849c" }
        "menu border"   = { fg = "#6c7086" }
        "menu selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        "help"        = { bg = "#1e1e2e" }
        "help title"  = { fg = "#cdd6f4", bold = true, underline = true }
        "help border" = { fg = "#6c7086" }

        "preview"        = { fg = "#cdd6f4", bg = "#1e1e2e" } 
        "preview border" = { fg = "#6c7086" }

        # --- Confirmations & Undo ---
        "confirmation"          = { bg = "#1e1e2e" }
        "confirmation text"     = { fg = "#f9e2af", bold = true }
        "confirmation dimmed"   = { fg = "#7f849c" }
        "confirmation border"   = { fg = "#f9e2af", bold = true }
        "confirmation selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        "undo"                       = { bg = "#1e1e2e" }
        "undo confirmation dimmed"   = { fg = "#7f849c" }
        "undo confirmation selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

        # --- Misc UI Elements ---
        "details"             = { fg = "#cdd6f4" }
        "details selected"    = { bg = "#313244", fg = "#cdd6f4", bold = true }
        "completion"          = { fg = "#cdd6f4" }
        "completion selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }
        "rebase"              = { bold = true }

        # --- Core Jujutsu Concepts ---
        "workspace" = { fg = "#74c7ec" }
        "branch"    = { fg = "#b4befe" }
        "commit"    = { fg = "#a6e3a1" }
        "file"      = { fg = "#cdd6f4" }
        "change"    = { fg = "#fab387" }
        "bookmark"  = { fg = "#f5c2e7" }
  '';

  programs.fish.shellAbbrs = {
    ju = "jjui";
  };
}
