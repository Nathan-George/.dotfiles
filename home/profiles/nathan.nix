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
    firefox
    globalprotect-openconnect
    discord
    obsidian
    jetbrains.idea-ultimate
    eclipses.eclipse-java
    vscode
    rars

    # shell utils
    libnotify
    wl-clipboard
    gcc
    python313

    # games
    prismlauncher
  ];

}
