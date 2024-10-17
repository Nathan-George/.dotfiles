# theme colors

{ nix-colors, ... }:

{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme = {
    palette = {
      base00 = "#151515"; # ----
      base01 = "#212121"; # ---
      base02 = "#555555"; # --
      base03 = "#757575"; # -
      base04 = "#959595"; # +
      base05 = "#B5B5B5"; # ++
      base06 = "#CBCBCB"; # +++
      base07 = "#F0F0F0"; # ++++

      base08 = "#db3030";  # red
      base09 = "#f09724";  # orange
      base0A = "#fad32f";  # yellow
      base0B = "#65cf48";  # green
      base0C = "#11a8cd";  # aqua/cyan
      base0D = "#2479c8";  # blue
      base0E = "#bc3fbc";  # magenta
      base0F = "#9c5916";  # brown

      base10 = "#f04a4a"; # light red
      base11 = "#f5a640"; # light orange
      base12 = "#f7db63"; # light yellow
      base13 = "#7fe065"; # light green
      base14 = "#29b6d9"; # light aqua/cyan
      base15 = "#3b8eea"; # light blue
      base16 = "#d670d6"; # light magenta
      base17 = "#d9ab66"; # light brown
      
      base18 = "#ad0909"; # dark red
      base19 = "#d67d0b"; # dark orange
      base1A = "#e8c017"; # dark yellow
      base1B = "#3cad1d"; # dark green
      base1C = "#0789a8"; # dark aqua/cyan
      base1D = "#0e5aa1"; # dark blue
      base1E = "#991599"; # dark magenta
      base1F = "#663605"; # dark brown
    };
  };
}
