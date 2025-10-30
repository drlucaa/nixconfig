{ pkgs, ... }:
{
  fonts = {
    fontconfig.defaultFonts = {
      serif = [ "Monaspace Neon" ];
      sansSerif = [ "Monaspace Neon" ];
      monospace = [ "Monaspace Neon" ];
    };

    packages = with pkgs; [
      jetbrains-mono
      dejavu_fonts
      nerd-fonts.ubuntu
      nerd-fonts.monaspace
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      comic-mono
      dancing-script
      bdp-fonts
    ];

    enableDefaultPackages = true;
  };
}
