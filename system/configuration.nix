# main configuration
{pkgs, ...}: {
  imports = [
    ./config/docker.nix
    ./config/garbage.nix
    ./config/locale.nix
    ./config/power.nix
    ./hardware-configuration.nix
  ];

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # framework hardware stuff
  services.fwupd.enable = true;

  # enable fingerprint
  services.fprintd.enable = true;

  # enable networking
  networking.networkmanager.enable = true;
  # disable network wait service (this caused boot to be slow)
  systemd.services.NetworkManager-wait-online.enable = false;

  # enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.xpadneo.enable = true;

  programs.hyprland.enable = true;

  # window manager
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [oxygen];

  # display manager
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "plasma";
  };

  # make apps not blurry
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # enable X11 windowing system
  services.xserver.enable = true;
  # X11 keymap
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # enable CUPS to print documents.
  services.printing.enable = true;

  # enable sound with pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # hostname
  networking.hostName = "nixos";

  # user account
  users.users."nathan" = {
    isNormalUser = true;
    description = "Nathan George";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # utils
    kitty
    brightnessctl
    file
    firefox
    killall
    neofetch
    traceroute
    unzip
    vim
    wget
    zip

    # home manager
    home-manager

    # nix lsp
    nixd
  ];

  # enable git
  programs.git.enable = true;

  # emable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # environment variables
  environment.sessionVariables = {
    # make default editor vim
    EDITOR = "vim";

    # xdg stuff
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  system.stateVersion = "23.11"; # do not change
}
