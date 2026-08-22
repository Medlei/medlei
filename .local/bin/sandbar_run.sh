#!/bin/sh

[ -z "$DIR_SANDBARRUNTIME" ] && export DIR_SANDBARRUNTIME="$XDG_RUNTIME_DIR/sandbar"

[ -d "$DIR_SANDBARRUNTIME" ] || {
	rm -f "$DIR_SANDBARRUNTIME"
	mkdir "$DIR_SANDBARRUNTIME"
}

fd_fifo="$DIR_SANDBARRUNTIME/$$"
mkfifo "$fd_fifo"

while true
do cat "$fd_fifo"
done | sandbar -font monospace:size=10 -scale 2