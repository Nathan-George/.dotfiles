# fonts

{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # only install certain patches of nerdfonts (to save space)
    (nerdfonts.override { fonts = [
      "DejaVuSansMono" # for yakuake
    ]; })
  ];
}
