# define colors for theming

{ lib, ... }:

with lib; let
  validHexChars = "0123456789abcdefABCDEF";
  colorType = mkOptionType {
    name = "color";
    description = "6-digit hexadecimal color";
    check = s: (isString s) && (all (c: hasInfix c validHexChars) (stringToCharacters s));
  };
in {
  options.colors = mkOption {
    type = types.attrsOf colorType;
    default = {};
    example = literalExpression ''
      {
        background = "17262b";
      }
    '';
    description = "Attribute set of user-defined hex colors";
  };
}
