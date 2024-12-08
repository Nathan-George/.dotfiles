# waybar config
{
  config,
  pkgs,
  ...
}: {
  # nerd font
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

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
      spacing = 20;
      modules-left = [
        "custom/nixlogo"
        "clock"
      ];
      modules-center = [];
      modules-right = [
        "idle_inhibitor"
        "network"
        "memory"
        "cpu"
        "battery"
      ];

      # modules
      "custom/nixlogo" = {
        "format" = "  ";
        "tooltip" = false;
        "on-click" = ". ${config.scripts.logoutPrompt}";
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p %a, %b %d}";
        "tooltip-format" = "<big>{:%I:%M:%S}</big>";
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
        "tooltip-format-activated" = "Idle inhibitor: on";
        "tooltip-format-deactivated" = "Idle inhibitor: off";
      };
      "network" = {
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "tooltip-format" = "IP = {ipaddr}/{cidr}\nOn {ifname} via {gwaddr}";
      };
      "memory" = {
        "format" = "Mem {}%";
      };
      "cpu" = {
        "format" = "CPU {usage}%";
        "tooltip" = true;
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
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
    };

    style = with config.colorScheme.palette; ''
      * {
        font-family: Hack Nerd Font Propo, monospace;
        font-size: 13px;
        padding: 0;
        margin: 0;
      }
      window#waybar {
        background-color: #${base00};
        color: #${base07};
        transition-property: background-color;
        transition-duration: .5s;
      }
      button {
        border: none;
        border-radius: 0;
      }
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
        background: inherit;
      }
      .modules-right {
        padding-right: 12px;
      }
      #custom-nixlogo {
        font-size: 15px;
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
