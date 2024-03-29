{ config, pkgs, ... }:

with pkgs; let
  # define R packages (used later)
  RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ mosaic ggformula dplyr Lock5Data ]; };
in {

  imports = [
    modules/paths.nix
  ];

  home = {
    username = "jayden";
    homeDirectory = "/home/jayden";
    stateVersion = "23.11"; # do not change
  };

  # set paths
  paths = rec {
    root = builtins.toString ./.;
    scripts = "${root}/scripts";
  };

  # enable home manager
  programs.home-manager.enable = true;

  # git config
  programs.git = {
    enable = true;
    userName = "JaydenPahukula";
    userEmail = "jayden.pahukula@gmail.com";
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # allow certain insecure packages
  nixpkgs.config.permittedInsecurePackages = [ 
    "electron-25.9.0" # obsidian needs this
  ];

  home.packages = with pkgs; [
    
    # apps
    discord
    obsidian
    spotify
    vscode

    # school stuff
    eclipses.eclipse-java
    RStudio-with-my-packages

    # hyprland stuff
    hyprpaper
    kitty
    rofi-wayland

    # notifications
    dunst
    libnotify # (dunst needs this)

    # clipboard
    cliphist
    wl-clipboard
    wl-clip-persist

    # screenshot
    grim
    slurp

    # icon theme
    flat-remix-icon-theme # https://drasite.com/flat-remix

    # fonts
    font-awesome # for waybar

  ];

  # enable waybar
  programs.waybar.enable = true;


  home.file = {

    # cursor theme
    ".icons/default".source = "${pkgs.simp1e-cursors}/share/icons/Simp1e-Adw";

  };

  # environment variables
  home.sessionVariables = {
    pypy = "pypy3";
  };

}
