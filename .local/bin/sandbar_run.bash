#!/bin/sh

[ -z "$DIR_SANDBARRUNTIME" ] && export DIR_SANDBARRUNTIME="$XDG_RUNTIME_DIR/sandbar"

[ -d "$DIR_SANDBARRUNTIME" ] || {
	rm -f "$DIR_SANDBARRUNTIME"
	mkdir "$DIR_SANDBARRUNTIME"
}

fd_fifo="$DIR_SANDBARRUNTIME/$$"
mkfifo "$fd_fifo"

while :; do cat "$fd_fifo"; done | sandbar -font monospace:size=10 -scale 2 &

while
	[ $(("$SECONDS" % 5)) = 0 ] && {
		read batStatus </sys/class/power_supply/BAT0/status
		time="`date +%R`"

		if [ "$batStatus" = Discharging ]
			then batStatus=
			else batStatus=
		fi
	}

	[ $(("$SECONDS" % 15)) = 0 ] && {
		read _ sinkVol sinkMute <<<"`wpctl get-volume @DEFAULT_SINK@`"
		read _ _ srcMute <<<"`wpctl get-volume @DEFAULT_SOURCE@`"

		if [ -n "$sinkMute" ]
		then
			sinkMute=
			unset sinkVol
		else
			sinkMute=
			sinkVol="$sinkVol "
		fi

		if [ -n "$srcMute" ]
			then srcMute=
			else srcMute=
		fi
	}

	[ $(("$SECONDS" % 30)) = 0 ] && {
		date="`date +'%a, %b'` `suffixedDate.bash`"
		read batCap </sys/class/power_supply/BAT0/capacity
		timeZone="`date +%Z`"
	}

	echo "all status [$batCap% $batStatus] [$sinkVol$sinkMute] [$srcMute] [$date $time $timeZone ]"
do sleep 1
done >"$fd_fifo" 2>/dev/null