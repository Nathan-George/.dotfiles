# plasma task switcher
{...}: {
  programs.plasma = {
    # unused keybinds
    shortcuts = {
      kwin = {
        "Walk Through Windows of Current Application" = "";
        "Walk Through Windows of Current Application (Reverse)" = "";
      };
    };
    # do not preview windows
    configFile."kwinrc"."TabBox"."HighlightWindows" = false;
  };
}
