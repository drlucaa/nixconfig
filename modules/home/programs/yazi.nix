{
  ...
}:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = true;
        ratio = [
          1
          4
          3
        ];
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "f" ];
          run = "plugin fzf";
          desc = "Fuzzy find files by name";
        }
        {
          on = [ "d" ];
          run = "plugin zoxide";
          desc = "Fuzzy jump to directory";
        }

        {
          on = [ "O" ];
          run = "shell 'open .' --confirm";
          desc = "Open current directory in Finder";
        }

        {
          on = [ "?" ];
          run = "help";
          desc = "Open help menu";
        }

        {
          on = [ "<C-g>" ]; # Example: Ctrl + g
          run = "shell 'lazygit' --block --confirm";
          desc = "Open lazygit";
        }
        {
          on = [ "<C-j>" ]; # Example: Ctrl + j
          run = "shell 'jjui' --block --confirm";
          desc = "Open jjui";
        }

        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/nixconfig";
          desc = "Go to Nix config";
        }
        {
          on = [
            "g"
            "d"
          ];
          run = "cd ~/dev";
          desc = "Go to dev";
        }
      ];
    };
  };
}
