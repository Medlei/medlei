#!/bin/sh

dir="$XDG_RUNTIME_DIR/sandbar"

[ -d "$dir" ] || {
	rm -f "$dir"
	mkdir "$dir"
}

FIFO="$dir/$$"
mkfifo "$FIFO"
trap "rm $FIFO" EXIT
statusLine.sh >"$FIFO" 2>/dev/null &

while :
do cat "$FIFO"
done | sandbar -font monospace:size=10 -scale 2