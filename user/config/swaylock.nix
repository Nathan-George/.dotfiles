# swaylock config

{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = let
      TRANSPARENT = "00000000";
    in {
      screenshots = true;
      effect-blur = "16x3";
      disable-caps-lock-text = true;
      indicator = true;
      indicator-caps-lock = true;
      inside-color = TRANSPARENT;
      inside-clear-color = TRANSPARENT;
      inside-caps-lock-color = TRANSPARENT;
      inside-ver-color = TRANSPARENT;
      inside-wrong-color = TRANSPARENT;
      indicator-image = "${config.assets.lockIcon}";
      line-color = TRANSPARENT;
      line-clear-color = TRANSPARENT;
      line-caps-lock-color = TRANSPARENT;
      line-ver-color = TRANSPARENT;
      line-wrong-color = TRANSPARENT;
      ring-color = "555555";
      ring-clear-color = "888888";
      text-color = TRANSPARENT;
      text-clear-color = TRANSPARENT;
      text-caps-lock-color = TRANSPARENT;
      text-ver-color = TRANSPARENT;
      text-wrong-color = TRANSPARENT;
    };
  };
}
