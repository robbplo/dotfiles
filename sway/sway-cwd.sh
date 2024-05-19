#!/bin/bash

pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
ppid=$(pgrep --newest --parent ${pid})
cwd=$(readlink /proc/${ppid}/cwd || echo $HOME)

[ -d $cwd ] && echo $cwd || echo $HOME
