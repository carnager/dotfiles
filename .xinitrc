# set general options
if [ ! "$DBUS_SESSION_BUS_ADDRESS" ]; then
	exec dbus-launch --exit-with-session ~/.xinitrc "$@" || exit
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

cd $HOME
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
    exec gnome-session
else exec i3
fi
