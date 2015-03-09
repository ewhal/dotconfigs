#!/bin/sh
export PATH="$PATH:$HOME/.bin"
export EDITOR="vim"

#settings
xset -b
xrdb -merge ~/.Xresources

#Screen setup
xrandr --output VGA-0 --mode 1440x900 --output DVI-0 --mode 1024x768 --left-of VGA-0

#hide mouse when not used
#unclutter -root -visible &

eval `dbus-launch --sh-syntax --exit-with-session`

# Setup dual display...
#exec startxfce4
#gnome-sessio

GPG_ENVFILE="$HOME/.gnupg/gpg-agent.env"
if [ -x $(which gpg-agent) ]; then
    eval "$(gpg-agent --enable-ssh-support --daemon --write-env-file "$GPG_ENVFILE")"
    export GPG_AGENT_INFO
fi

#compton --config ~/.i3/compton.conf &
i3

[ -x $(which gpg-agent) ] && kill $(grep GPG_AGENT_INFO "$GPG_ENVFILE" | cut -d: -f 2) 2>/dev/null

true
