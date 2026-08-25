#!/bin/sh

trap "
	kill $!
	SECONDS=0
" SIGHUP

while
	[ "`expr $SECONDS % 5`" = 0 ] && {
		read bat_status </sys/class/power_supply/BAT0/status
		[ "$bat_status" = Discharging ] && bat_status= || bat_status=
		time_time=`date +%R`
	}

	[ "`expr $SECONDS % 15`" = 0 ] && network="`iwctl station wlan0 show | awk '/Connected network/ { for (i=3; i < NF; printf "%s ", $i++); print $NF }'`"

	[ "`expr $SECONDS % 30`" = 0 ] && {
		audio_sink="`wpctl get-volume @DEFAULT_SINK@ | awk '{ print NF < 3 ? $2 * 100 "% " : "" }'`"
		audio_src="`wpctl get-volume @DEFAULT_SOURCE@ | awk '{ print NF < 3 ? "" : "" }'`"
	}

	[ "`expr $SECONDS % 60`" = 0 ] && {
		read bat_cap </sys/class/power_supply/BAT0/capacity
		time_date="`date +'%a, %b'` `suffixedDate.sh`"
		time_zone=`date +%Z`
	}

	echo "all status [ $audio_sink ] [ $audio_src ] [ $bat_cap% $bat_status ] [ ${network:=disconnected} ] [ $time_date $time_time $time_zone  ]"
do sleep 1 & wait
done