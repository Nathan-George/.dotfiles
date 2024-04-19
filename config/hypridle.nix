# hypridle config
# MUST BE USED WITH HYPRLAND AND HYPRLOCK

{ config, pkgs, lib, ... }:

{
  # install hypridle package
  home.packages = [ pkgs.hypridle ];

  # add to startup
  wayland.windowManager.hyprland.settings.exec-once = [ "hypridle" ];

  # make config file
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances
      before_sleep_cmd = loginctl lock-session    # lock before suspend
      after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display
    }

    # listener {
    #   timeout = 150                                # after 2.5 minutes
    #   on-timeout = brightnessctl -s set 15%        # set brightness to 15%
    #   on-resume = brightnessctl -r                 # monitor backlight restore.
    # }

    listener {
      timeout = 600                                 # after 10 minutes
      on-timeout = loginctl lock-session            # show lock screen
    }

    listener {
      timeout = 900                                 # after 15 minutes
      on-timeout = hyprctl dispatch dpms off        # turn screen off
      on-resume = hyprctl dispatch dpms on          # turn screen back on
    }

    listener {
      timeout = 3600                                # after 60 mins
      on-timeout = systemctl suspend                # suspend pc
    }
  '';
}