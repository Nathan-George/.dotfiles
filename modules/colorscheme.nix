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
    base00 = "1d2021"; # ----
    base01 = "3c3836"; # ---
    base02 = "504945"; # --
    base03 = "665c54"; # -
    base04 = "bdae93"; # +
    base05 = "d5c4a1"; # ++
    base06 = "ebdbb2"; # +++
    base07 = "fbf1c7"; # ++++
    base08 = "fb4934"; # red
    base09 = "fe8019"; # orange
    base0A = "fabd2f"; # yellow
    base0B = "b8bb26"; # green
    base0C = "8ec07c"; # aqua/cyan
    base0D = "83a598"; # blue
    base0E = "d3869b"; # purple
    base0F = "d65d0e"; # brown
  };
}