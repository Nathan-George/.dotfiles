# This file manages commonly used scripts makes their
# paths available under `options.scripts`.

{ config, lib, pkgs, ... }:

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
  # config.scripts = {
  #   appLauncher = "${import ./applauncher.nix { inherit pkgs; }}/bin/applauncher";
  # };

  config.home.packages = [
    (import ./applauncher.nix { inherit pkgs; })
  ];

}