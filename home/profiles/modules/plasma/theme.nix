# plasma theme
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # cursor theme package
    hackneyed
  ];

  programs.plasma = {
    # fonts = let
    #   Noto = {
    #     family = "Noto Sans";
    #     pointSize = 10;
    #   };
    #   NotoSmall = {
    #     family = "Noto Sans";
    #     pointSize = 8;
    #   };
    #   Hack = {
    #     family = "Hack";
    #     pointSize = 10;
    #   };
    # in {
    #   general = Noto;
    #   fixedWidth = Hack;
    #   small = NotoSmall;
    #   toolbar = Hack;
    #   menu = Hack;
    #   windowTitle = Hack;
    # };

    workspace = {
      wallpaper = ./assets/wallpaper.png;

      cursor.theme = "Hackneyed";
    };
  };
}
