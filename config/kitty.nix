# kitty config

{ config, lib, pkgs, ... }:

{

  # config
  programs.kitty = {
    enable = true;

    settings = {
      touch_scroll_multiplier = 3;

      # colors
      background_opacity = "0.75";
      foreground = "#${config.colorScheme.base07}";
      background = "#${config.colorScheme.base00}";
      # black
      color0 = "#${config.colorScheme.base02}";
      color8 = "#${config.colorScheme.base03}";
      # red
      color1 = "#${config.colorScheme.base08}";
      color9 = "#${config.colorScheme.base08}";
      # green
      color2 = "#${config.colorScheme.base0B}";
      color10 = "#${config.colorScheme.base0B}";
      # yellow
      color3 = "#${config.colorScheme.base0A}";
      color11 = "#${config.colorScheme.base0A}";
      # blue
      color4 = "#${config.colorScheme.base0D}";
      color12 = "#${config.colorScheme.base0D}";
      # magenta
      color5 = "#${config.colorScheme.base0E}";
      color13 = "#${config.colorScheme.base0E}";
      # cyan
      color6 = "#${config.colorScheme.base0C}";
      color14 = "#${config.colorScheme.base0C}";
      # white
      color7 = "#${config.colorScheme.base04}";
      color15 = "#${config.colorScheme.base06}";
    };
  };
}
