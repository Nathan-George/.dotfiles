# dolphin modules

{ inputs, pkgs, lib, ... }:

let
  CompletionModes = [ "None" "Auto" "Man" "Shell" "Popup" "PopupAuto" ];
  # ^https://api.kde.org/frameworks/kcompletion/html/classKCompletion.html#a927c284d89e41d976412201b68ca67e9
in {
  options.dolphin.general = with lib; {
    EditableUrl = mkOption {
      type = types.bool;
      description = "Should the URL be editable for the user";
      default = false;
    };
    UrlCompletionMode = mkOption {
      type = types.enum CompletionModes;
      description = "Text completion mode of the URL Navigator";
      default = "PopupAuto";
    };
    ShowFullPath = mkOption {
      type = types.bool;
      description = "Should the full path be shown inside the location bar";
      default = false;
    };
    ShowFullPathInTitlebar = mkOption {
      type = types.bool;
      description = "Should the full path be shown in the title bar";
      default = false;
    };
    OpenExternallyCalledFolderInNewTab = mkOption {
      type = types.bool;
      description = "Should an externally called folder open in a new tab in an existing Dolphin instance";
      default = false;
    };
    Version = mkOption {
      type = types.int;
      description = "Internal config version of Dolphin, mainly Used to determine whether an updated version of Dolphin is running, so as to migrate config entries that were removed/renamed ...etc";
      default = 0;
    };
    ModifiedStartupSettings = mkOption {
      type = types.bool;
      description = "Have the startup settings been modified (internal setting not shown in the UI)";
      default = false;
    };
    HomeUrl = mkOption {
      type = types.str;
      description = "Home URL";
      default = "${config.home.homeDirectory}";
      defaultText = literalExpression "home.homeDirectory";
    };
    RememberOpenedTabs = mkOption {
      type = types.bool;
      description = "Remember open folders and tabs";
      default = true;
    };
    SplitView = mkOption {
      type = types.bool;
      description = "Place two views side by side";
      default = false;
    };
    FilterBar = mkOption {
      type = types.bool;
      description = "Should the filter bar be shown";
      default = false;
    };
    GlobalViewProps = mkOption {
      type = types.bool;
      description = "Should the view properties be used for all folders";
      default = true;
    };
    BrowseThroughArchives = mkOption {
      type = types.bool;
      description = "Browse through archives";
      default = false;
    };
    ConfirmClosingMultipleTabs = mkOption {
      type = types.bool;
      description = "Ask for confirmation when closing windows with multiple tabs.";
      default = true;
    };
    ConfirmClosingTerminalRunningProgram = mkOption {
      type = types.bool;
      description = "Ask for confirmation when closing windows with a program that is still running in the Terminal panel.";
      default = true;
    };
    RenameInline = mkOption {
      type = types.bool;
      description = "Rename single items inline";
      default = true;
    };
    ShowSelectionToggle = mkOption {
      type = types.bool;
      description = "Show selection toggle";
      default = true;
    };
    ShowPasteBarAfterCopying = mkOption {
      type = types.bool;
      description = "Show a bar for easy pasting after a cut or copy was done using the selection mode bottom bar.";
      default = true;
    };
    UseTabForSwitchingSplitView = mkOption {
      type = types.bool;
      description = "Use tab for switching between right and left view";
      default = false;
    };
    CloseActiveSplitView = mkOption {
      type = types.bool;
      description = "Close the view in focus when turning off split view";
      default = true;
    };
    OpenNewTabAfterLastTab = mkOption {
      type = types.bool;
      description = "New tab will be open after last one";
      default = false;
    };
    ShowToolTips = mkOption {
      type = types.bool;
      description = "Show item information on hover";
      default = false;
    };
    ViewPropsTimestamp = mkOption {
      type = types.str;
      description = "Timestamp since when the view properties are valid";
    };
    AutoExpandFolders = mkOption {
      type = types.bool;
      description = "Use auto-expanding folders for all view types";
      default = false;
    };
    ShowStatusBar = mkOption {
      type = types.bool;
      description = "Show the statusbar";
      default = true;
      # <emit signal="showStatusBarChanged" />
    };
    ShowZoomSlider = mkOption {
      type = types.bool;
      description = "Show zoom slider in the statusbar";
      default = true;
    };
    ShowSpaceInfo = mkOption {
      type = types.bool;
      description = "Show the space information in the statusbar";
      default = true;
    };
    LockPanels = mkOption {
      type = types.bool;
      description = "Lock the layout of the panels";
      default = true;
    };
    EnlargeSmallPreviews = mkOption {
      type = types.bool;
      description = "Enlarge Small Previews";
      default = true;
    };
    SortingChoice = mkOption {
      type = types.enum [ "Natural" "CaseInsensitive" "CaseSensitive" ];
      description = "Choose Natural, Case Sensitive, or Case Insensitive order of sorting the items";
      default = "Natural";
      # <emit signal="sortingChoiceChanged" />
    };
    HideXTrashFile = mkOption {
      type = types.bool;
      description = "Also hide files with application/x-trash mimetype";
      default = false;
    };
  };
}