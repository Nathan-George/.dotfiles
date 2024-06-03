{ pkgs }:

pkgs.writeShellScriptBin "applauncher.sh" ''
  if pgrep -x rofi; then
    killall rofi
  else
    ${pkgs.rofi}/bin/rofi -show drun -show-icons
  fi
''
