{
  pkgs,
  self,
  ...
}:
let
  ignores = import "${self}/config/ignores.nix";
  # Convert ignores to fd exclude flags (e.g., -E '.git' -E 'node_modules')
  excludeFlags = builtins.concatStringsSep " " (map (x: "-E '${x}'") ignores);
  # Use fd as the default command for fzf to respect ignores
  fdCmd = "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git ${excludeFlags}";
  fdDirCmd = "${pkgs.fd}/bin/fd --type d --hidden --follow --exclude .git ${excludeFlags}";
in
{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableFishIntegration = true;
    defaultCommand = fdCmd;
    fileWidgetCommand = fdCmd;
    changeDirWidgetCommand = fdDirCmd;
  };
}
