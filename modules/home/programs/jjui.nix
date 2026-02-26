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
    "dimmed"   = { fg = "#45475a", bg = "#1e1e2e" }
    "title"    = { fg = "#89b4fa", bold = true }
    "shortcut" = { fg = "#cba6f7" }
    "matched"  = { fg = "#f5e0dc" }
    "border"   = { fg = "#585b70" }
    "selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    # --- Global Markers & States ---
    "source_marker" = { bg = "#89dceb", fg = "#1e1e2e", bold = true }
    "target_marker" = { bg = "#a6e3a1", fg = "#1e1e2e", bold = true }
    "success"       = { fg = "#a6e3a1", bold = true }
    "error"         = { fg = "#eba0ac", bold = true }

    # --- Status Panel ---
    "status"          = { bg = "#181825" }
    "status title"    = { fg = "#1e1e2e", bg = "#74c7ec", bold = true }
    "status shortcut" = { fg = "#f5c2e7" }
    "status dimmed"   = { fg = "#45475a" }

    # --- Revset Input ---
    "revset title"               = { fg = "#89b4fa", bold = true }
    "revset text"                = { fg = "#cdd6f4", bold = true }
    "revset completion text"     = { fg = "#cdd6f4" }
    "revset completion matched"  = { fg = "#f5e0dc", bold = true }
    "revset completion dimmed"   = { fg = "#45475a" }
    "revset completion selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    # --- Revisions & Logs ---
    "revisions"                      = { fg = "#cdd6f4" }
    "revisions selected"             = { bg = "#313244", fg = "#cdd6f4", bold = true }
    "revisions dimmed"               = { fg = "#45475a" }
    "revisions details selected"     = { bg = "#313244", bold = true }
    "revisions details added"        = { fg = "#a6e3a1" }
    "revisions details modified"     = { fg = "#f9e2af" }
    "revisions details deleted"      = { fg = "#f38ba8" }
    "revisions details renamed"      = { fg = "#89b4fa" }
    "revisions rebase source_marker" = { bold = true }
    "revisions rebase target_marker" = { bold = true }

    "oplog selected"  = { bg = "#313244", fg = "#cdd6f4", bold = true }
    "evolog"          = { fg = "#cdd6f4" }
    "evolog selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    # --- Floating Menus & Panels (Neutral Borders) ---
    "menu"          = { bg = "#1e1e2e" }
    "menu title"    = { fg = "#1e1e2e", bg = "#f5c2e7", bold = true }
    "menu shortcut" = { fg = "#f5c2e7" }
    "menu matched"  = { fg = "#f5e0dc", bold = true }
    "menu dimmed"   = { fg = "#45475a" }
    "menu border"   = { fg = "#bac2de" } # Changed to a crisp, light gray
    "menu selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    "help"        = { bg = "#1e1e2e" }
    "help title"  = { fg = "#a6e3a1", bold = true, underline = true }
    "help border" = { fg = "#bac2de" } # Changed to match menu border

    "preview"        = { fg = "#cdd6f4", bg = "#1e1e2e" } 
    "preview border" = { fg = "#bac2de" } # Changed to match menu border

    # --- Confirmations & Undo ---
    "confirmation"          = { bg = "#1e1e2e" }
    "confirmation text"     = { fg = "#89b4fa", bold = true }
    "confirmation dimmed"   = { fg = "#45475a" }
    "confirmation border"   = { fg = "#eba0ac", bold = true } # Kept red to demand attention before destructive actions
    "confirmation selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    "undo"                       = { bg = "#1e1e2e" }
    "undo confirmation dimmed"   = { fg = "#45475a" }
    "undo confirmation selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }

    # --- Misc UI Elements ---
    "details"             = { fg = "#cdd6f4" }
    "details selected"    = { bg = "#313244", fg = "#cdd6f4", bold = true }
    "completion"          = { fg = "#cdd6f4" }
    "completion selected" = { bg = "#313244", fg = "#cdd6f4", bold = true }
    "rebase"              = { bold = true }

    # --- Core Jujutsu Concepts ---
    "workspace" = { fg = "#74c7ec" }
    "branch"    = { fg = "#89dceb" }
    "commit"    = { fg = "#a6e3a1" }
    "file"      = { fg = "#f5e0dc" }
    "change"    = { fg = "#eba0ac" }
    "bookmark"  = { fg = "#f5c2e7" }
  '';

  programs.fish.shellAbbrs = {
    ju = "jjui";
  };
}
