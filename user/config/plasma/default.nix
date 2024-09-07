# plasma config entrypoint

{ ... }:

{
  imports = [
    ./input.nix
    ./panels.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
  };
}
