{
  inputs,
  ...
}:
{
  imports = [
    inputs.paneru.darwinModules.paneru
  ];

  services.paneru = {
    enable = true;

    settings = {
      bindings = {
        window_focus_west = "cmd - h";
        window_focus_east = "cmd - l";
        window_focus_north = "cmd - k";
        window_focus_south = "cmd - j";
      };
    };
  };
}
