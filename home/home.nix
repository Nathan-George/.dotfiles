# main home configuration
{pkgs, ...}: {
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable home manager
  programs.home-manager.enable = true;

  home = rec {
    username = "nathan";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # do not change
  };

}
