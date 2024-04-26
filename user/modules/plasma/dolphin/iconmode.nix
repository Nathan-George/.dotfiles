# dolphin icon mode settings

{ config, lib, ... }:

{
  options.plasma.dolphin.iconMode = with lib; {
    EditableUrl = mkOption {
      type = types.bool;
      description = "Should the URL be editable for the user";
      default = false;
    };
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
      default = config.plasma.constants.KIconLoader.StdSizes.Huge;
    };
    TextWidthIndex = mkOption {
      type = types.int;
      description = "Text width index";
      default = 1;
    };
    MaximumTextLines = mkOption {
      type = types.int;
      description = "Maximum textlines (0 means unlimited)";
      default = 3;
    };
  };
}