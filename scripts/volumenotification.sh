#!/usr/bin/env bash

# get volume level
volume="$(
  amixer get Master |                         # get volume info
  awk '$0~/%/{print $5}' | tr -d '[]%' |      # isolate numbers
  awk 'BEGIN{RS=" "}{s+=$0}END{print s/NR}'   # average numbers
)"

# choose icon
if [[ $volume -eq 0 ]]; then
  icon="audio-volume-low"
elif [[ $volume -le 40 ]]; then
  icon="audio-volume-medium"
else
  icon="audio-volume-high"
fi

# create notification
dunstify -a "volume" -u low -t 1000 -i $icon -h int:value:$volume "Volume"
