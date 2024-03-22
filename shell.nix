
{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSEnv {
  name = "fhs";
  targetPkgs = pkgs: with pkgs; [
    cmake
    gcc
    glibc.static
    gnumake
    nodejs
  ];
}).env

