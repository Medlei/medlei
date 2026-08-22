#!/bin/sh

trap "
	kill $!
	SECONDS=0
" SIGHUP

while
	[ "`expr $SECONDS % 5`" = 0 ] && {
		read batStatus </sys/class/power_supply/BAT0/status
		[ "$batStatus" = Discharging ] && batStatus= || batStatus=
		time="`date +%R`"
	}

	[ "`expr $SECONDS % 15`" = 0 ] && {
		read _ sinkVol sinkMute <<-EOF
			`wpctl get-volume @DEFAULT_SINK@`
		EOF

		[ -n "$sinkMute" ] && {
			sinkMute=
			unset sinkVol
		} || {
			sinkMute=
			sinkVol="$sinkVol "
		}

		read _ _ srcMute <<-EOF
			`wpctl get-volume @DEFAULT_SOURCE@`
		EOF

		[ -n "$srcMute" ] && srcMute= || srcMute=

		read _ _ networkSSID <<-EOF
			`iwctl station wlan0 show | grep 'Connected network'`
		EOF

		[ -n "$networkSSID" ] || networkSSID=disconnected
	}

	[ "`expr $SECONDS % 30`" = 0 ] && {
		date="`date +'%a, %b'` `suffixedDate.sh`"
		read batCap </sys/class/power_supply/BAT0/capacity
		timeZone="`date +%Z`"
	}

	echo "all status [ $batCap% $batStatus ] [ $networkSSID ] [ $sinkVol$sinkMute ] [ $srcMute ] [ $date $time $timeZone  ]"
do sleep 1 & wait
done