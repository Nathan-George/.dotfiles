{ config, pkgs, ... }:

{

  imports = [
    ./assets
    ./config/chrome.nix
    ./config/labwc.nix
    ./config/lf.nix
    ./config/qimgv.nix
    ./config/waybar.nix
    ./config/yakuake.nix
    ./scripts
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

  # enable bash
  programs.bash.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # allow certain insecure packages
  nixpkgs.config.permittedInsecurePackages = [ 
    "electron-25.9.0" # obsidian needs this
  ];

  home.packages = with pkgs; [
    
    # apps
    beeper
    discord
    kate
    obsidian
    spotify
    vscode

    # utils
    trashy
    grim
    slurp
    wl-clipboard

  ];

  # cursor
  home.pointerCursor = {
    name = "Hackneyed";
    package = pkgs.hackneyed;
  };

}
