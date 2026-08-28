{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # ============================================================================
  # SYSTEM FOUNDATION & BOOT
  # ============================================================================
  networking.hostName = "nixos";
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "23.11"; # do not change

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Bootloader & Hibernation Setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["resume_offset=143177728"];
  boot.resumeDevice = "/dev/disk/by-uuid/63e2fe76-b072-4fc0-b1ac-55be22d8c3e4";

  # ============================================================================
  # HARDWARE & POWER MANAGEMENT
  # ============================================================================
  services.fwupd.enable = true; # firmware updates
  services.fprintd.enable = true;
  powerManagement.enable = true;

  hardware.xpadneo.enable = true;
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-experimental;
    powerOnBoot = true;
    settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = "true";
    };
  };

  # Sleep & Lid Behavior
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  systemd.sleep.settings.Sleep = {
    MemorySleepMode = "[s2idle] deep";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hybernate";
    HandlePowerKey = "suspend-then-hybernate";
  };

  services.usbmuxd.enable = true; # connecting to iOS devices

  # ============================================================================
  # NETWORKING & SOUND
  # ============================================================================
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
  };

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ============================================================================
  # DESKTOP ENVIRONMENT (GNOME & WAYLAND)
  # ============================================================================
  #services.xserver = {
  #  enable = true;
  #  xkb.layout = "us";
  #  xkb.variant = "";
  #};

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };

  # ============================================================================
  # VIRTUALIZATION & SERVICES
  # ============================================================================
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  services.printing = {
    enable = true;
    cups-pdf.enable = true;
    drivers = [pkgs.hplip];
  };

  # ============================================================================
  # USER ACCOUNTS & ENVIRONMENT
  # ============================================================================
  users.users."nathan" = {
    isNormalUser = true;
    description = "Nathan George";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
      "docker"
    ];
  };

  environment.sessionVariables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL = "1"; # Force Wayland for Electron apps
  };

  # System level packages
  environment.systemPackages = with pkgs; [
    ghostty
    vim
    curl
  ];

  # System Programs
  programs.git.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
