# plasma config entrypoint

{ pkgs, ... }:

{
  imports = [
    ./input.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # setup displays on startup
    startup.startupScript."displaySetup".text = ''
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.1.scale.1.3 \
        output.1.position.0,0 \
        output.2.scale.1 \
        output.2.position.-1920,0 \
    '';

  };
}
