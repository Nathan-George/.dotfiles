{pkgs, ...}: {
  imports = [
    ./modules
    ./school.nix
  ];

  # enable bash
  programs.bash = {
    enable = true;
    initExtra = ''
      jmp() {
        cd "$HOME/jmp/$1"
      }

      _jmp_completions() {
        local cur="''${COMP_WORDS[COMP_CWORD]}"
        local dirs=$(command ls -1 "$HOME/jmp" 2>/dev/null)
        COMPREPLY=( $(compgen -W "$dirs" -- "$cur") )
      }

      complete -F _jmp_completions jmp
    '';
  };
  

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

  home.shellAliases = {
    devshell = "nix flake new -t \"github:numtide/devshell\" .";
  };

  fonts.fontconfig.enable = true;
}
