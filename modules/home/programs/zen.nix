{
  inputs,
  username,
  ...
}:
{
  config = {
    home-manager.users.${username} =
      { ... }:
      {
        imports = [ inputs.zen-browser.homeModules.beta ];
        programs.zen-browser = {
          enable = true;
        };
      };
  };
}
