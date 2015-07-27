#!/bin/bash

# $HOME/.config/herbstluftwm/panel.sh
# bl1nk - http://kuchen.io

set -f

function uniq_linebuffered() {
	awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

monitor=${1:-0}

separator="\f0 | \fr"

herbstclient pad 0 25
herbstclient pad 1 0

{
	while true ; do
		date +'date_day %a, %d. %b  '
		date +'date_time %H:%M  '
		sleep 1 || break
	done > >(uniq_linebuffered) &
	date_pid=$!
	herbstclient --idle
	kill $date_pid
} 2> /dev/null | {
TAGS=( $(herbstclient tag_status $monitor) )
unset TAGS[${#TAGS[@]}]
date_time=""
date_day=""
windowtitle=""
visible=true

while true ; do
	echo -n "\c"
	for i in "${TAGS[@]}" ; do
		case ${i:0:1} in
			'#') # current tag
				echo -n "\u4\fr"
				;;
			'+')
				echo -n "\u3\fr"
				;;
			'-')
				echo -n "\u2\fr"
				;;
			':')
				echo -n "\ur\fr"
				;;
			'!') # urgent tag
				echo -n "\u1\f1"
				;;
			*)
				echo -n "\ur\f2"
				;;
		esac
		echo -n " ${i:1} " | tr '[:lower:]' '[:upper:]'
	done
	echo -n "\l"
	echo -n " ${windowtitle//^/^^}"
	echo -n "\r\ur\fr\br"
#	echo -n "$separator"
        echo -n "\f4"
        echo -n "$(mpc current)"
        echo -n "$separator"
	echo -n "$date_time" | tr '[:lower:]' '[:upper:]'
	echo -n " \f2"
	echo -n "$date_day  " | tr '[:lower:]' '[:upper:]'
	echo
	# wait for next event
	read line || break
	cmd=( $line )
	# find out event origin
	case "${cmd[0]}" in
		tag*)
			#TAGS=( $(herbstclient tag_status $monitor) )
			TAGS=( $(herbstclient tag_status ) )
			unset TAGS[${#TAGS[@]}]
			;;
		date_time)
			date_time="${cmd[@]:1}"
			;;
		date_day)
			date_day="${cmd[@]:1}"
			;;
		quit_panel)
			exit
			;;
		reload)
			exit
			;;
		focus_changed|window_title_changed)
			windowtitle="$(echo ${cmd[@]:2}|cut -c 1-100)"
			;;
	esac
done
} 2> /dev/null | bar $1


