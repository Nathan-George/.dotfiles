# plasma config entrypoint

{ ... }:

{
  imports = [
    ./input.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
  };
}
