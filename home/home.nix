# main home configuration
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./assets
    ./config/chrome.nix
    ./config/colors.nix
    ./config/fonts.nix
    ./config/git.nix
    ./config/lf.nix
    ./config/mako.nix
    ./config/plasma
    ./config/python.nix
    ./config/trashy.nix
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
    wl-clipboard
    libnotify

    # games
    prismlauncher
    smassh
  ];
}
