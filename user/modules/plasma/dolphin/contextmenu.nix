# dolphin context menu settings

{ config, lib, ... }:

{
  options.plasma.dolphin.contextMenu = with lib; {
    ShowCopyMoveMenu = mkOption {
      type = types.bool;
      description = "Show 'Copy To' and 'Move To' commands in context menu";
      default = false;
    };
    ShowAddToPlaces = mkOption {
      type = types.bool;
      description = "Show 'Add to Places' in context menu.";
      default = true;
    };
    ShowSortBy = mkOption {
      type = types.bool;
      description = "Show 'Sort By' in context menu.";
      default = true;
    };
    ShowViewMode = mkOption {
      type = types.bool;
      description = "Show 'View Mode' in context menu.";
      default = true;
    };
    ShowOpenInNewTab = mkOption {
      type = types.bool;
      description = "Show 'Open in New Tab' and 'Open in New Tabs' in context menu.";
      default = true;
    };
    ShowOpenInNewWindow = mkOption {
      type = types.bool;
      description = "Show 'Open in New Window' in context menu.";
      default = true;
    };
    ShowOpenInSplitView = mkOption {
      type = types.bool;
      description = "Show 'Open In Split View' in context menu.";
      default = true;
    };
    ShowCopyLocation = mkOption {
      type = types.bool;
      description = "Show 'Copy Location' in context menu.";
      default = true;
    };
    ShowDuplicateHere = mkOption {
      type = types.bool;
      description = "Show 'Duplicate Here' in context menu.";
      default = true;
    };
    ShowOpenTerminal = mkOption {
      type = types.bool;
      description = "Show 'Open Terminal' in context menu.";
      default = true;
    };
    ShowCopyToOtherSplitView = mkOption {
      type = types.bool;
      description = "Show 'Copy to other split view' in context menu.";
      default = true;
    };
    ShowMoveToOtherSplitView = mkOption {
      type = types.bool;
      description = "Show 'Move to other split view' in context menu.";
      default = true;
    };
  };
}