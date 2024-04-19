{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11"; # do not change

  # framework hardware stuff
  services.fwupd.enable = true;

  # automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # hostname
  networking.hostName = "nixos";

  # enable networking
  networking.networkmanager.enable = true;

  # enable X11 windowing system
  services.xserver.enable = true;
  
  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # enable CUPS to print documents.
  services.printing.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # enable fingerprint
  services.fprintd.enable = true;

  # enable flakes 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # time zone
  time.timeZone = "America/Denver";

  # locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # X11 keymap
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # power/sleep options
  services.logind.lidSwitch = "hibernate";
  services.logind.powerKey = "ignore";

  # user account
  users.users.jayden = {
    isNormalUser = true;
    description = "Jayden";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # kde plasma
  services.xserver.desktopManager.plasma5.enable = true;

  # sddm
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.defaultSession = "plasma (Wayland)";

  # make apps not blurry
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = with pkgs; [

    # apps
    google-chrome

    # utils
    brightnessctl
    file
    killall
    neofetch
    playerctl
    # pypy3  it broken :(
    python3
    unzip
    vim
    zip

    # home manager
    home-manager

  ];
  
  # enable git
  programs.git.enable = true;

  # enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # environment variables
  environment.sessionVariables = {

    # make default editor vim
    EDITOR = "vim";

    # xdg stuff
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  # bash aliases
  programs.bash.shellAliases = {
    pypy = "pypy3";
  };

}
