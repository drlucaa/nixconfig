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
      rev = "5ab41d0c03159781011772de54125ded3b37a87d";
      hash = "sha256-y7fc9zwzMAEXiyJ2zmEsyK+LsUNBPjzFgOnlaqAl3YU=";
    }
    {
      owner = "rust-lang";
      repo = "rust";
      rev = "1.97.1";
      hash = "sha256-Dzn5cIldhuYZySxnCaaWijEiz8nY3W17+kvhhHuMPOE=";
    }
    {
      owner = "tokio-rs";
      repo = "tokio";
      rev = "tokio-1.53.1";
      hash = "sha256-iqOVizrAu3C+ewChQCTK03LB1Jjq1+gCgFmOLuo1b7I=";
    }
    {
      owner = "clap-rs";
      repo = "clap";
      rev = "v4.6.4";
      hash = "sha256-hKVSCRIoNRXgx1BzSbvWFp41eTTgbtaWP9lCzJNH7mU=";
    }
    {
      owner = "tokio-rs";
      repo = "tracing";
      rev = "tracing-0.1.44";
      hash = "sha256-Un0HxRcPCxs3GB2jcyw2GAMMvE574EXTQY1FudFqX1A=";
    }
    {
      name = "tracing-subscriber";
      displayName = "Tracing Subscriber";
      owner = "tokio-rs";
      repo = "tracing";
      rev = "tracing-subscriber-0.3.23";
      hash = "sha256-w6nmLTInmRWNp617852wsh2jVTjvkbI0nPu0vLLxfCc=";
    }
    {
      owner = "hashintel";
      repo = "hash";
      rev = "error-stack@0.8.0";
      hash = "sha256-jMaFKmeqNI3ssEo/Knp2GqdyFJ7bs1vLcClm4h4Q+yg=";
    }
    {
      owner = "dtolnay";
      repo = "thiserror";
      rev = "2.0.19";
      hash = "sha256-6dOJnABKTphcP7u94bW5sBMVpgLMGyw/N+OkAeJDSGw=";
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
          "*": deny
          read: allow
          glob: allow
          grep: allow
          list: allow
          bash: ask
          edit: deny
          task: deny
          webfetch: allow
          websearch: allow
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
    package = pkgs.unstable.opencode;

    settings = {
      permission = {
        external_directory = {
          "/nix/store/**" = "allow";
          "~/tool-corpora/**" = "allow";
        };
      };
    };

    agents = {
      tool-advisor = mkToolAdvisorAgent toolCorpora;
    };

    commands = mkCommands toolCorpora // {
      hunk = ''
        ---
        description: Review the active Hunk session and add inline findings
        agent: build
        ---

        Perform a complete code review of the currently active Hunk session.

        Follow these steps immediately. Do not respond with an acknowledgement or ask what to do next.

        1. Run `hunk skill path`.
        2. Read and follow the returned Hunk skill file.
        3. Locate the active review for this repository using:
           - `hunk session list`
           - `hunk session get --repo .`
        4. Inspect the complete review structure with:
           - `hunk session review --repo . --json`
        5. Review all changed files and hunks. Use `--include-patch` only when the structured review does not contain enough context.
        6. Look specifically for:
           - correctness bugs and regressions
           - security or privacy issues
           - incorrect error handling
           - race conditions and state-management errors
           - broken edge cases
           - API or compatibility problems
           - missing or inadequate tests
           - unnecessary complexity that creates concrete maintenance risk
        7. Add each actionable finding as an inline Hunk comment at the most precise changed line. Batch comments with `hunk session comment apply --repo . --stdin` where practical.
        8. Do not add comments for formatting preferences, vague concerns, or speculative issues without a plausible failure scenario.
        9. Do not modify the code.
        10. When finished, report:
            - the number of findings by severity
            - a concise description of each finding
            - whether the changes appear safe to merge
            - any areas you could not verify

        Treat `$ARGUMENTS` as additional review instructions or scope. If it is empty, review the entire active changeset.
      '';
    };
  };

  home.file = mkHomeFiles toolCorpora;
}
