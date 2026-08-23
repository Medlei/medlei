#!/bin/sh

[ -z "$XDG_RUNTIME_DIR" ] && exit 1
dir_sandbarRuntime="$XDG_RUNTIME_DIR/sandbar"

[ -d "$dir_sandbarRuntime" ] || {
	rm -f "$dir_sandbarRuntime"
	mkdir "$dir_sandbarRuntime"
}

fd_fifo="$dir_sandbarRuntime/$$"
mkfifo "$fd_fifo"
trap "rm $fd_fifo" EXIT

while :
do cat "$fd_fifo"
done | sandbar -font monospace:size=10 -scale 2