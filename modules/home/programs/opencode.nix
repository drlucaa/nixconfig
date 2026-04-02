{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.unstable.opencode ];

  xdg.configFile."opencode" = {
    source = ../../../config/opencode;
    recursive = true;
  };

  home.file."tool-corpora/svelte.dev".source = pkgs.fetchFromGitHub {
    owner = "sveltejs";
    repo = "svelte.dev";
    rev = "06d398351b2fa8187d72e3aa4a88bd8a7239ea9a";
    hash = "sha256-8QSqyohYyFBnIveJKNNfHQPWIScOsH4LftT/REqK4kM=";
  };

  home.file."tool-corpora/better-auth".source = pkgs.fetchFromGitHub {
    owner = "better-auth";
    repo = "better-auth";
    rev = "03278b5ad62c4cea61a8373bb7fe522519b31a42"; # v1.5.6
    hash = "sha256-De6mvCw8xzHHaKPwFhMfvWSj2ZE8zbwujZl3ZIoSuC8=";
  };

  home.file."tool-corpora/effect".source = pkgs.fetchFromGitHub {
    owner = "Effect-TS";
    repo = "effect";
    rev = "6e3782af7ad047bc006e543f2285fc35bcf798d9"; # effect@3.21.0
    hash = "sha256-EKlC78FMvHGWUEC546cDT2MRy2sCvsu4oXPZPYkvLCM=";
  };

  home.file."tool-corpora/deno".source = pkgs.fetchFromGitHub {
    owner = "denoland";
    repo = "deno";
    rev = "6ddbb099662ea78a62af79484ae773cd9058c815"; # v2.7.11
    hash = "sha256-EIO6uGH2smEUHD5mCNstoFzGhvPHTxVWED7l01zfBpg=";
  };

  home.file."tool-corpora/zod".source = pkgs.fetchFromGitHub {
    owner = "colinhacks";
    repo = "zod";
    rev = "ca3c8629c0c2715571f70b44c2433cad3db7fe4e"; # v4.3.6
    hash = "sha256-cFogoiClqG34prZB9ejPqrHuMxuSglY6GGTFPsUpK4U=";
  };

  home.file."tool-corpora/tailwindcss".source = pkgs.fetchFromGitHub {
    owner = "tailwindlabs";
    repo = "tailwindcss";
    rev = "d596b0c43d36ad5099c983930fb155e089cbc291"; # v4.2.2
    hash = "sha256-kntjwvFhUpmpbHHf7brhjoR0dHuv3+RHV+gcNjAmVog=";
  };

  home.file."tool-corpora/helix".source = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = "website";
    rev = "9703c4e91da7b8ab42fe54a9167d8955d2dda405";
    hash = "sha256-BaY2iWzADObxaKmnqVSWiCJrZ7+Jg0mrr5iJ7msmy8Y=";
  };
}
