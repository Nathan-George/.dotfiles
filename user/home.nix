{ config, pkgs, ... }:

{

  imports = [
    ./assets
    ./config/chrome.nix
    ./config/git.nix
    ./config/plasma
    ./config/waybar.nix
    ./config/yakuake.nix
  ];

  home = rec {
    username = "jayden";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # do not change
  };

  # enable home manager
  programs.home-manager.enable = true;

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
    wl-clipboard

  ];

  # cursor
  home.pointerCursor = {
    name = "Hackneyed";
    package = pkgs.hackneyed;
  };

  # for mounting flash drives
  programs.bashmount.enable = true;

}
