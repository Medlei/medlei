#!/bin/sh

command -v wlsunset >/dev/null && {
	[ -f "$XDG_CONFIG_HOME/coordinates" ] && read lat lon <"$XDG_CONFIG_HOME/coordinates"
	wlsunset -L "${lon:-'-73.9'}" -l "${lat:-'40.7'}"
}