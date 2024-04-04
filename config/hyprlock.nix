# hyprlock config
# MUST BE USED WITH HYPRIDLE

{ config, pkgs-unstable, lib, ... }:

{
  # install hypridle package
  home.packages = [ pkgs-unstable.hyprlock ];

  # make config file
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {

    }

    background {
      monitor = 
      path = ${config.assets.wallpaper}
      blur_passes = 1
      blur_size = 8
    }

    input-field {
      monitor = 
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.33
      dots_center = false
      dots_rounding = -1
      outer_color = rgb(200, 200, 200)
      font_color = rgb(10, 10, 10)
      fade_on_empty = true
      fade_timeout = 1000
      placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off
      swap_font_color = false # see below

      position = 0, -20
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $TIME
      color = rgb(200, 200, 200)
      font_size = 25
      font_family = Noto Sans
      rotate = 0

      position = 0, 80
      halign = center
      valign = center
    }
  '';
}