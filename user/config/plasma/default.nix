# plasma config entrypoint

{ ... }:

{
  imports = [
    ./display.nix
    ./input.nix
    ./panels.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
  };
}
