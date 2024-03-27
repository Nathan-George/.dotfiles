#!/usr/bin/env bash

# get brightness level
cur="$( brightnessctl g )"
max="$( brightnessctl m )"
brightness="$(( 100 * $cur / $max ))"

# choose icon
if [[ $brightness -eq 0 ]]; then
  icon="display-brightness-off-symbolic"
elif [[ $brightness -le 30 ]]; then
  icon="display-brightness-low-symbolic"
elif [[ $brightness -le 70 ]]; then
  icon="display-brightness-medium-symbolic"
else
  icon="display-brightness-high-symbolic"
fi

# create notification
dunstify -a "volume" -u low -t 1000 -i $icon -h int:value:$brightness "Brightness"
