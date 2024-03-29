{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    # hyprland configuration
    settings = {

      # monitors
      monitor = [
        "eDP-1, 2256x1504, 0x0, 1.333333"
        "desc:Acer Technologies SB220Q 0x20104E9F, 1920x1080, -1920x0, 1"
        ", preferred, auto, 1"
      ];

      # startup
      exec-once = [

        # startup apps
        "waybar"
        "dunst"
        "discord"
        "hyprpaper"

        # clipboard init
        "wl-clip-persist --clipboard both"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # environment vars
      env = [
        "XCURSOR_SIZE,24"
        "GRIM_DEFAULT_DIR,$HOME/Pictures/screenshots" # default screenshot dir
      ];

      # settings
      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 5;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
        allow_tearing = false; # https://wiki.hyprland.org/Configuring/Tearing/
      };

      decoration = {
        rounding = 5;
        drop_shadow = false;
        blur = {
          enabled = true;
        };
      };

      animations = {
        enabled = true;
        animation = [
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {

        # keyboard
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        # mouse
        sensitivity = 0.5;
        accel_profile = "flat";
        natural_scroll = false;
        follow_mouse = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.5;
          tap-and-drag = false;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = -1;
        focus_on_activate = true;
      };

      dwindle = {
        preserve_split = true;
        # psuedotile = true; # not sure why this doesn't work
      };

      master = {
        new_is_master = true;
      };

      # keybinds
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive, "
        "$mainMod, E, exec, dolphin"
        "$mainMod, P, pseudo, "
        "$mainMod, J, togglesplit, "

        # screenshot
        ", Print, exec, grim -g '$(slurp -d)' | wl-copy"

        # clipboard history
        "$mainMod, V, exec, cliphist list | rofi -dmenu -p 'clipboard' | cliphist decode | wl-copy"

        # switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # move/resize window
        "$mainMod, mouse:272, moveactive"
        "$mainMod, mouse:273, resizeactive"
      ];

      bindr = [
        # app launcher
        "$mainMod, SUPER_L, exec, ${config.paths.scripts}/applauncher.sh"
      ];

      bindl = [
        # media keys
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"

        # mute key
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${config.paths.scripts}/volumenotification.sh"
      ];

      bindle = [
        # volume keys
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${config.paths.scripts}/volumenotification.sh"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ${config.paths.scripts}/volumenotification.sh"
      
        # brightness keys
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+ && ${config.paths.scripts}/brightnessnotification.sh"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && ${config.paths.scripts}/brightnessnotification.sh"
      ];

    };
  };
}
