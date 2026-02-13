{
  username,
  ...
}:
{
  config = {
    programs.fish.enable = true;

    home-manager.users.${username} =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
          package = pkgs.fish;

          shellAbbrs = {
            c = "clear";
            k = "kubectl";
            kx = "kubectx";

            # nix
            ngc = "sudo nix-collect-garbage -d";
            nd = "nix develop";
          };

          shellAliases = {
            tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
            tscp = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
            mkdir = "mkdir -p";
            rd = "rm -rf";
          };

          plugins = [
            {
              name = "tide";
              src = pkgs.fishPlugins.tide.src;
            }
            {
              name = "autopair";
              src = pkgs.fishPlugins.autopair.src;
            }
            {
              name = "fzf";
              src = pkgs.fishPlugins.fzf.src;
            }
            {
              name = "puffer";
              src = pkgs.fishPlugins.puffer.src;
            }
          ];

          functions = {
            fish_greeting = ''
              if not set -q _tide_left_items
                tide configure
              end
              fastfetch
            '';
            cx = "mkdir -p $argv && cd $argv";
            _tide_item_git = ''
              # Try jj first; if that fails, fall back to fish's normal git prompt.
              fish_jj_prompt; or fish_git_prompt
            '';
            fish_jj_prompt = ''
              # If jj isn't installed, there's nothing we can do
              # Return 1 so the calling prompt can deal with it
              if not command -sq jj
                  return 1
              end
              set -l info "$(
                  jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @ \
                      --template '
                          surround(
                              "(",
                              ")",
                              separate(
                                  " ",
                                  bookmarks.join(", "),
                                  change_id.shortest(),
                                  commit_id.shortest(),
                                  if(conflict, label("conflict", "×")),
                                  if(divergent, label("divergent", "??")),
                                  if(hidden, label("hidden prefix", "(hidden)")),
                                  if(immutable, label("node immutable", "◆")),
                                  coalesce(
                                      if(
                                          empty,
                                          coalesce(
                                              if(
                                                  parents.len() > 1,
                                                  label("empty", "(merged)"),
                                              ),
                                              label("empty", "(empty)"),
                                          ),
                                      ),
                                      label("description placeholder", "*")
                                  ),
                              )
                          )
                      '
              )"
              or return 1
              if test -n "$info"
                  printf ' %s' $info
              end
            '';
          };
        };
      };
  };
}
