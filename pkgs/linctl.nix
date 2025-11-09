{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "linctl";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "dorkitude";
    repo = "linctl";
    rev = "v0.1.1";
    hash = "sha256-ch9zhriLWaAdgyqbD2OPedziI+TACldNlP56A+P47I8=";
  };

  vendorHash = "sha256-Nt/V5IS0UY4ROh7epKmtAN3VDFJlCnqmKRk1AVRASgQ=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "A Linear CLI tool";
    homepage = "https://github.com/dorkitude/linctl";
    license = licenses.mit;
    mainProgram = "linctl";
  };
}
