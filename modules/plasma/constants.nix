
{ config, pkgs, lib, ... }:

with lib; {
  options.plasma.constants = mkOption {
    type = types.anything;
    default = {

      # completion mode enum
      # https://api.kde.org/frameworks/kcompletion/html/classKCompletion.html#a927c284d89e41d976412201b68ca67e9
      KCompletion.CompletionModes = {
        None = 1;
        Auto = 2;
        Man = 3;
        Shell = 4;
        PopupAuto = 5;
      };

      # icon sizes enum
      # https://api.kde.org/legacy/4.14-api/kdelibs-apidocs/kdeui/html/classKIconLoader.html#a731529b94f19e837155d2deb1e99b680
      KIconLoader.StdSizes = {
        Small = 16;
        SmallMedium = 22;
        Medium = 32;
        Large = 48;
        Huge = 64;
        Enormous = 128;
      };

    };
  };
}