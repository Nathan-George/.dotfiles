#!/usr/bin/env bash

if pgrep -x rofi; then
	killall rofi
else
	rofi -show drun -show-icons
fi

