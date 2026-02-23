{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "yaml-schema-router";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "traiproject";
    repo = "yaml-schema-router";
    rev = "v0.2.0";
    hash = "sha256-GFe5NPW8nxv+bQsG5G26WCf2Z6qrW1WAZBMWFZD8MFI=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "Content-based JSON schema routing for YAML LSP";
    homepage = "https://github.com/traiproject/yaml-schema-router";
    license = licenses.mit;
    mainProgram = "yaml-schema-router";
  };
}
