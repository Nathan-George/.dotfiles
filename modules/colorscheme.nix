# A module to manage a consistent, system-wide color scheme.
# Inspired by https://github.com/chriskempson/base16 and https://github.com/Misterio77/nix-colors.

{ config, lib, pkgs, ... }:

with lib; let
  validHexDigits = strings.stringToCharacters "0123456789abcdefABCDEF";
  hexColorType = mkOptionType {
    name = "hexColorType";
    description = "6-digit hexadecimal color";
    check = (s:
      isString s &&
      stringLength s == 6 &&
      lists.all (c: elem c validHexDigits) (strings.stringToCharacters s)
    );
  };
  hexColorOption = mkOption {
    type = hexColorType;
  };
in {
  
  # colorScheme option
  options.colorScheme = {
    base00 = hexColorOption;
    base01 = hexColorOption;
    base02 = hexColorOption;
    base03 = hexColorOption;
    base04 = hexColorOption;
    base05 = hexColorOption;
    base06 = hexColorOption;
    base07 = hexColorOption;
    base08 = hexColorOption;
    base09 = hexColorOption;
    base0A = hexColorOption;
    base0B = hexColorOption;
    base0C = hexColorOption;
    base0D = hexColorOption;
    base0E = hexColorOption;
    base0F = hexColorOption;
  };

  # define color scheme (using gruvbox for testing)
  config.colorScheme = {
    base00 = "161616"; # ----
    base01 = "2F2F30"; # ---
    base02 = "424445"; # --
    base03 = "565859"; # -
    base04 = "C0C2C3"; # +
    base05 = "CCCDCE"; # ++
    base06 = "D5D7D7"; # +++
    base07 = "F5F5F5"; # ++++
    base08 = "FB4934"; # red
    base09 = "FE8019"; # orange
    base0A = "FAD32F"; # yellow
    base0B = "7EBB26"; # green
    base0C = "4AC4A9"; # aqua/cyan
    base0D = "62C1D7"; # blue
    base0E = "CB86D3"; # purple
    base0F = "AE7442"; # brown
  };
}