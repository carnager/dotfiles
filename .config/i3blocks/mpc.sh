#!/bin/bash
_statusfile=''
if [[ ! -z ${1} ]]; then
    _statusfile="${1}"
fi
function print_output() {
    if [[ -z ${_statusfile} ]]; then
        echo "${1}"
    else
        echo "${1}" > "${_statusfile}"
    fi
}
while true; do
    playing="$(mpc current -f "[%artist% - ]%title% (%date%)")"
    if [[ -z $playing ]]; then
        playing=" ◼ Stopped"
        print_output "${playing}"
    else
        status="►"
        mpc | grep "\[paused\]" 1>/dev/null && status="▷"
        playing="$status $playing"
        print_output "${playing}"
    fi
    mpc idle player
    sleep 2
done

