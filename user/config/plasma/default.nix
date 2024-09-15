# plasma config entrypoint

{ ... }:

{
  imports = [
    ./display.nix
    ./input.nix
    ./kscreenlocker.nix
    ./panels.nix
    ./powerdevil.nix
    ./shortcuts.nix
    ./theme.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
  };
}
