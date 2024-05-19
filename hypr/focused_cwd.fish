#!/usr/bin/fish -N
# Get the cwd of the currently focused terminal window

set pid (hyprctl activewindow | grep 'pid' | awk '{print $NF}')
set ppid (pgrep --newest --parent "$pid")
set cwd (readlink /proc/"$ppid"/cwd || echo "$HOME")

[ -d "$cwd" ] && echo "$cwd" || echo "$HOME"

