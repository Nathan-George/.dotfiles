{pkgs, ...} : {
  imports = [
    ./modules
  ];

  # enable bash
  programs.bash.enable = true;

  # allow certain insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # obsidian needs this
  ];

  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    # terminal
    ghostty

    # apps
    discord
    obsidian
    jetbrains.idea-ultimate
    vscode

    # shell utils
    libnotify
    wl-clipboard

    # games
    prismlauncher
  ];

}
