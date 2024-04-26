# dolphin compact mode settings

{ config, lib, ... }:

{
  options.plasma.dolphin.compactMode = with lib; {
    UseSystemFont = mkOption {
      type = types.bool;
      description = "Use system font";
      default = true;
    };
    # ViewFont = mkOption {
    #   type = Font;
    #   default = QFont();
    # };
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
    MaximumTextWidthIndex = mkOption {
      type = types.int;
      description = "Maximum text width index (0 means unlimited)";
      default = 0;
    };
  };
}