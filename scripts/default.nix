# This file stores all scripts in the nix-store and makes their
# paths available under `options.scripts`.

{ config, lib, ... }:

with lib; {

  # declare home manager option
  options.scripts = mkOption {
    type = types.attrsOf types.path;
    default = {};
    example = literalExpression { myScript = "./myscript.sh"; };
    description = "A collection of scripts and their paths in
    the nix store.";
  };

  # define scripts
  config.scripts = {
    appLauncher = ./applauncher.sh;
    brightnessNotification = ./brightnessnotification.sh;
    volumeNotification = ./volumenotification.sh;
  };

}
