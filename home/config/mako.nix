# mako config

{ config, ... }:

{
  services.mako = {
    enable = true;
    defaultTimeout = 3000;

    extraConfig = with config.colors; ''
      background-color=#${base00}
      border-color=#${base07}
      text-color=#${base07}
    '';
  };
}
