{ lib, ... }:

{
  imports = [
    ./autostart
    ./config
    ./environment
  ];

  options.programs.labwc.enable = lib.mkEnableOption ''
    Enable configuration management for labwc.
  '';
}