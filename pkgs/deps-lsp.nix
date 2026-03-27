{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "deps-lsp";
  version = "0.9.2";

  src = fetchFromGitHub {
    owner = "bug-ops";
    repo = "deps-lsp";
    rev = "v0.9.2";
    hash = "sha256-KJQarx2KjkPL+rkavsv/IFpI+6GCmKTc1m5cOP1pcOc=";
  };

  cargoHash = "sha256-p/0sFQGeLvSBzO2gDOVXoZeEENI3ghHpSI4flg97vPo=";
}
