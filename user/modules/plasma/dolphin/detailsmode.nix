# dolphin details mode settings

{ config, lib, ... }:

{
  options.plasma.dolphin.detailsMode = with lib; {
    # ViewFont = mkOption {
    #   type = types.Font;
    #   default = QFont();
    # };
    UseSystemFont = mkOption {
      type = types.bool;
      description = "Use system font";
      default = true;
    };
    IconSize = mkOption {
      type = types.int;
      description = "Icon size";
      default = config.plasma.constants.KIconLoader.StdSizes.Small;
    };
    PreviewSize = mkOption {
      type = types.int;
      description = "Preview size";
      default = config.plasma.constants.KIconLoader.StdSizes.Large;
    };
    ColumnPositions = mkOption {
      type = types.listOf types.int;
      description = "Position of columns";
      default = [ 0 1 2 3 4 5 6 7 8 ];
    };
    SidePadding = mkOption {
      type = types.ints.unsigned;
      description = "Side Padding";
      default = 20;
    };
    HighlightEntireRow = mkOption {
      type = types.bool;
      description = "Highlight entire row";
      default = true;
    };
    ExpandableFolders = mkOption {
      type = types.bool;
      description = "Expandable folders";
      default = true;
    };
  };
}