# dolphin content display settings

{ config, lib, ... }:

{
  options.plasma.dolphin.contentDisplay = with lib; {
    DirectorySizeMode = mkOption {
      type = types.enum [ "ContentCount" "ContentSize" "None" ];
      description = "How we display the size of directories";
      default = "ContentSize";
    };
    # ViewFont = mkOption {
    #   type = Font;
    #   default = QFont();
    # };
    RecursiveDirectorySizeLimit = mkOption {
      type = types.ints.unsigned;
      description = "Recursive directory size limit";
      default = 10;
    };
    UseShortRelativeDates = mkOption {
      type = types.bool;
      description = "if true we use short relative dates, if not short dates";
      default = true;
    };
    UsePermissionsFormat = mkOption {
      type = types.enum [ "SymbolicFormat" "NumericFormat" "CombinedFormat" ];
      description = "Maximum text width index (0 means unlimited)";
      default = "SymbolicFormat";
    };
  };
}