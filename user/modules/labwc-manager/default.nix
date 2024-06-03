{ lib, ... }:

{
  imports = [
    ./config
  ];

  options.programs.labwc.enable = lib.mkEnableOption ''
    Enable configuration management for labwc.
  '';
}