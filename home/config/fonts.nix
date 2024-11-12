# fonts
{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  # global fonts
  home.packages = with pkgs; [
  ];
}
