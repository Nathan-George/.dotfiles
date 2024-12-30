# main home configuration
{pkgs, ...}: {
  imports = [
    ./assets
    ./config/colors.nix
    ./config/fonts.nix
    ./config/git.nix
    ./config/lf
    #./config/mako.nix
    ./config/plasma
    #./config/python.nix
    ./config/trash.nix
    ./config/waybar.nix
    #./config/yakuake
    ./scripts
  ];

  home = rec {
    username = "nathan";
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
    # terminal
    ghostty

    # apps
    discord
    obsidian
    vscode
    neovim

    # utils
    libnotify
    wl-clipboard
  ];
}
