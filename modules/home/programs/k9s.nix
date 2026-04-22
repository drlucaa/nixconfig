{
  ...
}:
{
  programs.k9s = {
    enable = true;
  };

  programs.fish.shellAbbrs = {
    k = "kubectl";
    kk = "k9s";
    kx = "kubectx";
  };
}
