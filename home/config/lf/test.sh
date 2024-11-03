#!/usr/env sh

preview() {
  cat <<STOP | paste -s -d '' > "$LF_FIFO_UEBERZUG"
{
"action": "add", "identifier": "lf-preview",
"path": "$1", "x": $4, "y": $5, "width": $2, "height": $3,
"scaler": "contain"
}
STOP
}

# cat <<STOP | paste -s -d '' > "$LF_FIFO_UEBERZUG"
# {
# "action": "add", "identifier": "lf-preview",
# "path": "$1", "x": $4, "y": $5, "width": $2, "height": $3,
# "scaler": "contain"
# }
# STOP
