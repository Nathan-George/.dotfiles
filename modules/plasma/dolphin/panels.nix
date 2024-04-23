# dolphin panel settings

{ config, lib, ... }:

{
  options.plasma.dolphin.panels = with lib; {

    foldersPanel = {
      HiddenFilesShown = mkOption {
        type = types.bool;
        description = "Hidden files shown";
        default = false;
      };
      LimitFoldersPanelToHome = mkOption {
        type = types.bool;
        description = "Limit folders panel to home directory if inside home";
        default = true;
      };
      AutoScrolling = mkOption {
        type = types.bool;
        description = "Automatic scrolling";
        default = true;
      };
    };

    informationPanel = {
      previewsShown = mkOption {
        type = types.bool;
        description = "Previews shown";
        default = true;
      };
      previewsAutoPlay = mkOption {
        type = types.bool;
        description = "Auto-Play media files";
        default = false;
      };
      showHovered = mkOption {
        type = types.bool;
        description = "Show item on hover";
        default = true;
      };
      dateFormat = mkOption {
        type = types.enum [ "LongFormat" "ShortFormat" ];
        description = "Date display format";
        default = "LongFormat";
      };
    };

    placesPanel = {
      IconSize = mkOption {
        type = types.int;
        description = "Size of icons in the Places Panel (-1 means \"automatic\")";
        default = config.plasma.constants.KIconLoader.StdSizes.SmallMedium;
      };
    };

  };
}