{
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          fd
          fzf
          ripgrep
          jq
          yq
          fq
          age
          tlrc
          linctl
          glow
          pkgs.unstable.opencode
          pkgs.unstable.gemini-cli
          pkgs.unstable.typst
          pkgs.unstable.tdf
        ];
      };
  };
}
