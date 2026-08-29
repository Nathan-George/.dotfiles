# main home configuration
{pkgs, lib, ...}: {
  imports = [
    ./modules
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.username = "nathan";
  home.homeDirectory = "/home/nathan";
  home.stateVersion = "23.11"; # do not change

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ghostty
    nautilus
    papers
    gimp
    vlc
    ifuse # allow mounting iOS devices
    discord
    vscode
    prismlauncher
    zip
    unzip
    gcc
    python313
    wl-clipboard
    junicode
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  dconf.settings = {
    # Disable idle screen dimming and auto-sleep
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
      ambient-enabled = false; # Disables auto-brightness light sensor
    };

    # Disable screen blanking / turn-off timer (0 = Never)
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };

    # Optional: Disable lock screen on idle
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
  };
}
