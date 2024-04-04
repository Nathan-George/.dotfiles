# hyprlock config
# MUST BE USED WITH HYPRIDLE

{ config, pkgs-unstable, lib, ... }:

{
  # install hypridle package
  home.packages = [ pkgs-unstable.hyprlock ];

  # make config file
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      disable_loading_bar = false
      hide-cursor = false
      grace = 0
      no_fade_in = true
      no_fade_out = false
      ignore_empty_input = true
    }

    background {
      monitor = 
      path = ${config.assets.wallpaper}
      blur_passes = 1
      blur_size = 3
      brightness = 0.8
    }

    input-field {
      monitor =
      size = 200, 18
      outline_thickness = 4
      dots_size = 0.55
      dots_spacing = 0.3
      dots_center = false
      dots_rounding = -1
      outer_color = rgb(200, 200, 200)
      inner_color = rgb(200, 200, 200)
      font_color = rgb(10, 10, 10)
      fade_on_empty = true
      fade_timeout = 4000
      placeholder_text = 
      hide_input = false
      rounding = 2
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34)
      fail_text = 
      fail_transition = 300
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1
      invert_numlock = false
      swap_font_color = false

      position = 0, 50
      halign = center
      valign = bottom
    }

    label {
      monitor =
      text = $TIME
      color = rgb(200, 200, 200)
      font_size = 50
      font_family = Noto Sans
      rotate = 0

      position = 0, -200
      halign = center
      valign = top
    }
  '';
}