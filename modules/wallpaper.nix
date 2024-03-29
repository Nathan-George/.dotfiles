# This module provides an home manager option to define
# a static wallpaper using hyprpaper

{ config, lib, pkgs, ... }:

with lib; {
 
  options.wallpaper = mkOption {
    type = types.path;
    example = path/to/wallpaper.png;
    description = "Set the wallpaper";
  };

  config = {
    # add hyprpaper package
    home.packages = [
        pkgs.hyprpaper
    ];
    # create hyprpaper config file
    home.file.".config/hypr/hyprpaper.conf".text = ''
        preload = ${config.wallpaper}
        wallpaper = ,${config.wallpaper}
        ipc = off
    '';
  };
}
