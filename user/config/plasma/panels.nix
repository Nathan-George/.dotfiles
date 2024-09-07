# plasma-manager panels module
# NOTE: if panels don't update after reboot, try running ~/.local/share/plasma-manager/run_all.sh

{ ... }:

{
  programs.plasma.panels = [
    {
      floating = false;
      height = 24;
      hiding = "none";
      lengthMode = "fill";
      location = "top";
      screen = "all";

      widgets = [
        {
          kickoff = {
            sidebarPosition = "left";
            icon = "nix-snowflake-white";
            sortAlphabetically = false;
            compactDisplayStyle = true;
            favoritesDisplayMode = "list";
            applicationsDisplayMode = "list";
            showButtonsFor = "powerAndSession";
            showActionButtonCaptions = false;
            popupWidth = 1; # force min
            popupHeight = 1;
          };
        }
        "org.kde.plasma.panelspacer"
        {
          systemTray = {
            icons = {
              spacing = "small";
            };
            items = {
              shown = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
              ];
              hidden = [
                "Yakuake"
                "org.kde.plasma.volume"
                "org.kde.plasma.brightness"
                "org.kde.kscreen"
                "org.kde.plasma.keyboardindicator"
                "chrome_status_icon_1"
              ];
              extra = [
                "org.kde.plasma.brightness"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.notifications"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.printmanager"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.volume"
                "org.kde.kscreen"
                "org.kde.plasma.bluetooth"
                "Yakuake"
                "org.kde.plasma.battery"
                "chrome_status_icon_1"
              ];
            };
          };
        }
        # TODO: add system monitor widgets
        "org.kde.plasma.marginsseparator"
        {
          digitalClock = {
            date = {
              enable = true;
              format.custom = "MMM d, yyyy"; # https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method
              position = "besideTime";
            };
            time = {
              showSeconds = "onlyInTooltip";
              format = "12h";
            };
          };
        }
      ];
    }
  ];
}
