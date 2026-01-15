{pkgs, ...}: {
  imports = [
    ./modules
    ./school.nix
  ];

  # enable bash
  programs.bash.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # allow certain insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # obsidian needs this
  ];

  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    # terminal
    ghostty

    # apps
    firefox
    discord
    obsidian
    vscode
    vlc
    kdePackages.kdenlive

    # allow mounting IOS devices
    ifuse

    # shell utils
    libnotify
    wl-clipboard
    gcc
    python313

    # games
    prismlauncher
  ];

  fonts.fontconfig.enable = true;
}
