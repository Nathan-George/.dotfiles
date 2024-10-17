# waybar config

{ config, lib, pkgs, ... }:

{

  # install font awesome
  home.packages = [ pkgs.font-awesome ];

  # start on boot
  programs.plasma.startup.startupScript."waybar" = {
    runAlways = true;
    text = "waybar &";
  };

  # config
  programs.waybar = {
    enable = true;

    settings."mainBar" = {
      layer = "top";
      position = "top";
      height = 24;
      spacing = 4;
      modules-left = [];
      modules-center = [];
      modules-right = [ "idle_inhibitor" "network" "memory" "cpu" "battery" "clock" ];

      # modules
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
        "tooltip-format-activated" = "Idle inhibitor: on";
        "tooltip-format-deactivated" = "Idle inhibitor: off";
      };
      "clock" = {
        "interval" = 1;
        "format" = " {:%I:%M %p  %a, %b %d}";
        "tooltip-format" = "<big>{:%I:%M:%S}</big>";
      };
      "cpu" = {
        "format" = "CPU {usage}%";
        "tooltip" = true;
      };
      "memory" = {
        "format" = "Mem {}%";
      };
      "battery" = {
        "states" = {
          "warning" = 30;
          "critical" = 10;
        };
        "format" = "{capacity}% {icon}";
        "format-full" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-tooltip" = "Time to empty: {time}";
        "format-icons" = ["" "" "" "" ""];
      };
      "network" = {
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "tooltip-format" = "IP = {ipaddr}/{cidr}\nOn {ifname} via {gwaddr}";
      };
    };

    style = with config.colorScheme.palette; ''
      * {
        font-family: FontAwesome, monospace;
        font-size: 13px;
      }
      window#waybar {
        background-color: #${base00};
        color: #${base07};
        transition-property: background-color;
        transition-duration: .5s;
      }
      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
        background: inherit;
      }
      #window, #workspaces {
        margin: 0 4px;
      }
      #clock, #battery, #cpu, #memory, #network, #idle_inhibitor {
        padding: 0 10px;
      }
      #battery.charging, #battery.plugged {
        color: #${base0B};
      }
      #battery.warning {
        color: #${base0A};
      }
      #battery.critical, #idle_inhibitor.activated, #network.disconnected {
        color: #${base08};
      }
    '';
  };
}
