# This is a module to keep absolute paths consistent across
# all configurations

{ config, lib, pkgs, ... }:

with lib; let
  DEFAULT_PATH = builtins.toString ./..;
  EXAMPLE_PATH = "/home/user";
in {
  options.paths = {
    root = mkOption {
      type = types.path;
      default = "${DEFAULT_PATH}";
      example = "${EXAMPLE_PATH}";
      description = "Absolute path of this repository";
    };
    scripts = mkOption {
      type = types.path;
      default = "${DEFAULT_PATH}/scripts";
      example = "${EXAMPLE_PATH}/scripts";
      description = "Absolute path to the scripts directory";
    };
  };
}