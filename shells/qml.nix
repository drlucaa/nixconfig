{ pkgs }:
pkgs.mkShell {
  name = "qml-dev";
  packages = with pkgs; [
    qt6.qtdeclarative
    tree-sitter-qmljs
  ];
}
