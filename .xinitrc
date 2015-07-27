# set general options
xset +fp /usr/share/fonts/local/
xset +fp /usr/share/fonts/misc/
xrandr --auto --output DP-1 --primary --auto --output HDMI-1 --right-of DP-1
#setxkbmap de us -option compose:caps
pulseaudio --start
redshift &
udiskie -2 -s &
xrdb -load ~/.Xresources
~/.config/i3blocks/mpc.sh /tmp/now_playing &

# startx $foobar starts the session
if [[ $2 == gnome ]]; then
    gnome-session
elif [[ $2 == kde ]]; then
    exec openbox
else exec i3 --shmlog-size=26214400
fi
