# plasma config entrypoint

{ ... }:

{
  imports = [
    ./display.nix
    ./input.nix
    ./klipper.nix
    ./krunner.nix
    ./kscreenlocker.nix
    ./kwin.nix
    ./panels.nix
    ./powerdevil.nix
    ./shortcuts.nix
    ./spectacle.nix
    ./taskswitcher.nix
    ./theme.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
  };
}
