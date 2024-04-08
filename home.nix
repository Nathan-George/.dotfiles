{ config, pkgs, pkgs-unstable, ... }:

with pkgs; let
  # define R packages (used later)
  RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ mosaic ggformula dplyr Lock5Data ]; };
in {

  imports = [
    ./assets
    ./scripts
    ./modules/colorscheme.nix
    ./modules/wallpaper.nix
    ./config/hypridle.nix
    ./config/hyprland.nix
    ./config/hyprlock.nix
    ./config/kitty.nix
    ./config/waybar.nix
    ./config/lf.nix
  ];

  home = rec {
    username = "jayden";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # do not change
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

  ];

  # set wallpaper
  wallpaper = config.assets.wallpaper;

  home.file = {

    # cursor theme
    ".icons/default".source = "${pkgs.simp1e-cursors}/share/icons/Simp1e-Adw";

  };

  # environment variables
  home.sessionVariables = {

  };

}
