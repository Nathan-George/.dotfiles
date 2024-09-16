# plasma startup script for setting up displays

{ pkgs, ... }:

{
  programs.plasma.startup.startupScript."displaySetup".text = ''
    ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
      output.1.scale.1.3 \
      output.1.position.0,0 \
    ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
      output.2.scale.1 \
      output.2.position.-1920,0 \
  '';
}
