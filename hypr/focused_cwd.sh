#!/bin/bash
# Get the cwd of the currently focused terminal window

pid=$(hyprctl activewindow | jq '.pid')
ppid=$(pgrep --newest --parent "$pid")
cwd=$(readlink /proc/"$ppid"/cwd || echo "$HOME")

[ -d "$cwd" ] && echo "$cwd" || echo "$HOME"

