{
  pkgs,
  lib,
  ...
}:
let
  normalizeTool = tool: {
    name = tool.name or tool.repo;
    displayName =
      tool.displayName or (lib.toUpper (lib.substring 0 1 tool.repo) + lib.substring 1 (-1) tool.repo);
    path = tool.path or tool.name or tool.repo;
    owner = tool.owner;
    repo = tool.repo;
    rev = tool.rev;
    hash = tool.hash;
  };

  toolCorpora = map normalizeTool [
    {
      name = "helix";
      displayName = "Helix";
      owner = "helix-editor";
      repo = "website";
      rev = "9703c4e91da7b8ab42fe54a9167d8955d2dda405";
      hash = "sha256-BaY2iWzADObxaKmnqVSWiCJrZ7+Jg0mrr5iJ7msmy8Y=";
    }
  ];

  mkCommands =
    tools:
    lib.listToAttrs (
      map (tool: {
        name = tool.name;
        value = ''
          ---
          description: Ask a ${tool.displayName} question using the local ${tool.displayName} repo
          agent: tool-advisor
          ---

          Answer this ${tool.displayName} question using `~/tool-corpora/${tool.path}`:

          $ARGUMENTS
        '';
      }) tools
    );

  mkHomeFiles =
    tools:
    lib.listToAttrs (
      map (tool: {
        name = "tool-corpora/${tool.path}";
        value.source = pkgs.fetchFromGitHub {
          owner = tool.owner;
          repo = tool.repo;
          rev = tool.rev;
          hash = tool.hash;
        };
      }) tools
    );

  # Generate the tool-advisor agent description with all tools
  mkToolAdvisorAgent = tools: ''
        ---
        description: Advises on several tools by searching local source and docs repos
        mode: subagent
        permission:
          edit: deny
        ---

        You are a read-only tool advisor.

        You have access to these local codebases:

    ${lib.concatMapStringsSep "\n" (
      tool: "    - ${tool.displayName}: `~/tool-corpora/${tool.path}`"
    ) tools}

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
in
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
      tool-advisor = mkToolAdvisorAgent toolCorpora;
    };

    commands = mkCommands toolCorpora;
  };

  home.file = mkHomeFiles toolCorpora;
}
