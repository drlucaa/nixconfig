{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "deps-lsp";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "bug-ops";
    repo = "deps-lsp";
    rev = "v0.9.3";
    hash = "sha256-R7WTlZcVDTtN7t3CKGgsYasDRVb71ia+OB+h9dEZEv0=";
  };

  cargoHash = "sha256-k95a98hT7ZUMgnUSWepmj3OoT5z9GpXHpg460+uPcKQ=";
}
