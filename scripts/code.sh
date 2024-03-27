#!/usr/bin/env bash
if [[ -z "$NIXOS_OZONE_WL" ]]; then
  code
else
  tmp="$NIXOS_OZONE_WL"
  unset NIXOS_OZONE_WL
  code
  export NIXOS_OZONE_WL="$tmp"
fi

