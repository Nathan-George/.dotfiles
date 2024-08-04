# This file stores all assets in the nix-store and makes their
# paths available under `options.assets`.

{ config, lib, ... }:

with lib; {

  # declare home manager option
  options.assets = mkOption {
    type = types.attrsOf types.path;
    default = {};
    example = literalExpression { myImg = "./img.png"; };
    description = "A collection of assets and their paths in
    the nix store.";
  };

  # define assets
  config.assets = {
    wallpaper = ./wallpaper.png;
    lockIcon = ./lock.png;
  };

}
