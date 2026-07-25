{
  inputs,
  ...
}:
{

  imports = [
    inputs.hunk.homeManagerModules.default
  ];

  programs.hunk = {
    enable = true;

    settings = {
      theme = "catppuccin-mocha";

      watch = true;
      wrap_lines = true;
      agent_notes = true;

      prompt_save_view_preferences = false;
    };
  };
}
