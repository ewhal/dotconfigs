#!/bin/sh
export PATH="/usr/lib/hardening-wrapper/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/opt/opencascade/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export EDITOR="vim"
export GPG_ENVFILE="$HOME/.gnupg/gpg-agent.env"
if [ -x $(which gpg-agent) ]; then
    eval "$(gpg-agent --enable-ssh-support --daemon --write-env-file "$GPG_ENVFILE")"
    export GPG_AGENT_INFO
fi

#settings
xrdb -merge ~/.Xresources


# Setup dual display...
#xrandr --output LVDS-0 --mode 1280x800 --output VGA-0 --mode 1440x900 --right-of LVDS-0
#xrandr --output LVDS-0 --mode 1280x800 --output DP-1 --mode 1920x1080 --left-of LVDS-0
#xrandr --output DP-4 --off && xrandr --output DP-4 --mode 1024x768 --left-of LVDS-0

#hide mouse when not used
#exec unclutter -root -visible

dbus-launch --sh-syntax --exit-with-session &

setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl -option caps:escape &
urxvtd &


# composition manager
compton --config ~/.i3/compton.conf &

# Network Manager applet
>> /dev/null which nm-applet && nm-applet &
i3

true
