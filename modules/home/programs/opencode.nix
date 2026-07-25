{
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;

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
      '';
    };

    commands = {
      helix = ''
        ---
        description: Ask a Helix Docs question using the local Helix Docs repo
        agent: tool-advisor
        ---

        Answer this Helix Docs question using `~/tool-corpora/helix`:

        $ARGUMENTS
      '';
    };
  };

  home.file."tool-corpora/helix".source = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = "website";
    rev = "9703c4e91da7b8ab42fe54a9167d8955d2dda405";
    hash = "sha256-BaY2iWzADObxaKmnqVSWiCJrZ7+Jg0mrr5iJ7msmy8Y=";
  };
}
