# yakuake config
# look here for settings: https://github.com/KDE/yakuake/blob/master/app/config/yakuake.kcfg

{ config, lib, pkgs, ... }:

{

  home.packages = [
    pkgs.yakuake # install yakuake
    (import ./yakuake-session.nix { inherit pkgs; }) # create yakuake-session script
  ];

  # override default desktop entry
  xdg.desktopEntries."org.kde.yakuake" = {
    name = "Yakuake";
    genericName = "Drop-down Terminal";
    comment = "A drop-down terminal emulator based on KDE Konsole technology.";
    exec = "yakuake-session";
    icon = "yakuake";
    settings = {
      X-DBUS-StartupType = "Unique";
      X-DBUS-ServiceName = "org.kde.yakuake";
      DBusActivatable = "true";
    };
    startupNotify = false;
  };

  # make yakuake the default terminal
  home.sessionVariables = {
    TERMINAL = "yakuake-session";
  };

  # start yakuake on boot
  xdg.configFile."autostart/org.kde.yakuake.desktop".text = ''
    [Desktop Entry]
    Name=Yakuake
    Exec=yakuake
    icon=yakuake
  '';

  # config file
  xdg.configFile."yakuakerc".text = ''
    [Animation]
    Frames=10

    [Dialogs]
    FirstRun=false

    [Shortcuts]
    close-active-terminal=none
    close-session=Ctrl+W
    decrease-window-height=none
    decrease-window-width=none
    file_quit=none
    grow-terminal-bottom=none
    grow-terminal-left=none
    grow-terminal-right=none
    grow-terminal-top=none
    increase-window-height=none
    increase-window-width=none
    new-session=Ctrl+T
    next-session=Ctrl+Right
    next-terminal=none
    previous-session=Ctrl+Left
    previous-terminal=none
    rename-session=none
    split-left-right=none
    split-top-bottom=none
    switch-to-session-1=none
    switch-to-session-10=none
    switch-to-session-2=none
    switch-to-session-3=none
    switch-to-session-4=none
    switch-to-session-5=none
    switch-to-session-6=none
    switch-to-session-7=none
    switch-to-session-8=none
    switch-to-session-9=none
    toggle-session-monitor-activity=none
    toggle-session-monitor-silence=none
    view-full-screen=none

    [Window]
    DynamicTabTitles=true
    KeepOpen=false
    ShowTitleBar=false
  '';
}
