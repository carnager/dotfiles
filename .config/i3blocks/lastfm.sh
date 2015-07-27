#!/bin/bash

source ~/.config/clerk/config


ssh_lastfm=1
ssh_host=tauron

lastFMCheck () {
    if [[ -z $ssh_lastfm ]]; then
        if [[ -n $(pgrep $scrobbler) ]]; then
            echo "●"
        else
            echo "○"
        fi
    else
        mpds_check="$(ssh $ssh_host -q -t "pgrep $scrobbler")"
        if [[ -n "$mpds_check" ]]; then
            echo "●"
        else
            echo "○"
        fi
   fi
}

lastFMCheck
