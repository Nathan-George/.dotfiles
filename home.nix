{ config, pkgs, ... }:

with pkgs; let
  # define R packages (used later)
  RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ mosaic ggformula dplyr Lock5Data knitr ]; };
in {

  imports = [
    ./assets
    ./config/yakuake.nix
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

  ];

  # environment variables
  home.sessionVariables = {
    
  };

}
