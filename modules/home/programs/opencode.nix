{
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;

    settings = {
      "permission" = {
        "external_directory" = {
          "/nix/store/**" = "allow";
          "~/tool-corpora/**" = "allow";
        };
      };
    };

    agents = {
      tool-advisor = ''
        ---
        description: Advises on several tools by searching local source and docs repos
        mode: subagent
        permission:
          edit: deny
        ---

        You are a read-only tool advisor.

        You have access to these local codebases:

        - BetterAuth: `~/tool-corpora/better-auth`
        - Deno: `~/tool-corpora/deno`
        - Effect: `~/tool-corpora/effect`
        - Helix Docs: `~/tool-corpora/helix`
        - Svelte: `~/tool-corpora/svelte.dev`
        - Tailwind CSS: `~/tool-corpora/tailwindcss`
        - Zod: `~/tool-corpora/zod`

        When answering:

        1. First decide which codebases are relevant.
        2. Search only the relevant codebases.
        3. Read small amounts at a time.
        4. Prefer docs, README, examples, and reference material before internals.
        5. Distinguish between:
           - documented behavior
           - source-inferred behavior
           - your recommendation
        6. If the codebase does not clearly answer the question, say so.
        7. Be concise and practical.
        8. Give one good example, not five.

        Special instructions for Svelte:

        - generally just search the docs for the answer to the question, don't search
          the codebase unless you absolutely have to
        - always use typescript for svelte code (`<script lang="ts">`)
        - if you are just outputting stuff that goes in the script tag, tag the code as
          typescript code so the syntax highlighting in the view works correctly (AND DO
          NOT INCLUDE THE SCRIPT TAG IN THE OUTPUT)
        - if you are outputting full svelte files (script, markup, styles), tag the code
          as html so the syntax highlighting in the view works correctly
        - always try to answer the questions by just outputting stuff that goes in the
          script tag, only include markup and styles if absolutely necessary
      '';
    };

    agents = {
      zod = ''
        ---
        description: Ask a Zod question using the local Zod repo
        agent: tool-advisor
        ---

        Answer this Zod question using `~/tool-corpora/zod`:

        $ARGUMENTS
      '';
      bits = ''
        ---
        description: Ask a Bits-Ui Docs question using the local Bits-Ui Docs repo
        agent: tool-advisor
        ---

        Answer this Bits-Ui Docs question using `~/tool-corpora/bits`:

        $ARGUMENTS
      '';
      helix = ''
        ---
        description: Ask a Helix Docs question using the local Helix Docs repo
        agent: tool-advisor
        ---

        Answer this Helix Docs question using `~/tool-corpora/helix`:

        $ARGUMENTS
      '';
      efffect = ''
        ---
        description: Ask a Effect question using the local Effect repo
        agent: tool-advisor
        ---

        Answer this Effect question using `~/tool-corpora/effect`:

        $ARGUMENTS
      '';
      svelte = ''
        ---
        description: Ask a Svelte question using the local Svelte repo
        agent: tool-advisor
        ---

        Answer this Svelte question using `~/tool-corpora/svelte.dev`:

        $ARGUMENTS
      '';
      tailwind = ''
        ---
        description: Ask a Tailwind CSS question using the local Tailwind CSS repo
        agent: tool-advisor
        ---

        Answer this Tailwind CSS question using `~/tool-corpora/tailwindcss`:

        $ARGUMENTS
      '';
      better-auth = ''
        ---
        description: Ask a BetterAuth question using the local BetterAuth repo
        agent: tool-advisor
        ---

        Answer this BetterAuth question using `~/tool-corpora/better-auth`:

        $ARGUMENTS
      '';
    };
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

  home.file."tool-corpora/bits".source = pkgs.fetchFromGitHub {
    owner = "huntabyte";
    repo = "bits-ui";
    rev = "a6ee9aeb3d48aa2ffc78991c61e51d8d6e008f64"; # 2.17.3
    hash = "sha256-KnFE4I0eOhLbXS9Kfsit3R2FqRsENXnSJEDrpbO7fhs=";
  };
}
