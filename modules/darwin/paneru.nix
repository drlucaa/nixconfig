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
      options = {
        mouse_follows_focus = true;

        preset_column_widths = [
          0.25
          0.33
          0.5
          0.66
          0.75
          1
        ];
        window_resize_cycle = false;

        animation_speed = 14.0;
      };

      padding = {
        top = 8;
        bottom = 8;
        left = 8;
        right = 8;
      };

      windows = {
        all = {
          title = ".*";
          horizontal_padding = 6;
          vertical_padding = 6;
        };
      };

      decorations = {
        inactive = {
          dim = {
            opacity = -0.1;
          };
        };
      };

      bindings = {
        window_focus_west = "alt - h";
        window_focus_south = "alt - j";
        window_focus_north = "alt - k";
        window_focus_east = "alt - l";

        window_swap_west = "alt + shift - h";
        window_swap_south = "alt + shift - j";
        window_swap_north = "alt + shift - k";
        window_swap_east = "alt + shift - l";

        window_shrink = "alt - minus";
        window_grow = "alt - equal";

        window_fullwidth = "alt - f";
        window_manage = "alt + shift - f";
        window_center = "alt - c";
        window_stack = "alt - comma";
        window_unstack = "alt - slash";
        window_equalize = "alt + shift - equal";
        window_snap = "alt + shift - s";

        window_nextdisplay = "alt + shift - n";
        window_nextdisplaysend = "alt + ctrl + shift - n";
        mouse_nextdisplay = "alt + ctrl - n";

        window_virtualnum_1 = "alt - 1";
        window_virtualnum_2 = "alt - 2";
        window_virtualnum_3 = "alt - 3";
        window_virtualnum_4 = "alt - 4";
        window_virtualnum_5 = "alt - 5";
        window_virtualnum_6 = "alt - 6";
        window_virtualnum_7 = "alt - 7";
        window_virtualnum_8 = "alt - 8";
        window_virtualnum_9 = "alt - 9";

        window_virtualsendnum_1 = "alt + shift - 1";
        window_virtualsendnum_2 = "alt + shift - 2";
        window_virtualsendnum_3 = "alt + shift - 3";
        window_virtualsendnum_4 = "alt + shift - 4";
        window_virtualsendnum_5 = "alt + shift - 5";
        window_virtualsendnum_6 = "alt + shift - 6";
        window_virtualsendnum_7 = "alt + shift - 7";
        window_virtualsendnum_8 = "alt + shift - 8";
        window_virtualsendnum_9 = "alt + shift - 9";
      };
    };
  };
}
