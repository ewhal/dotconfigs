#!/bin/bash
#Arrays and such to be used throughout the program
FILES=( .zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc  )
USER=$(whoami)
HOME=$(pwd)
if [[ -f $HOME/sharfunct.sh ]]; then
    source sharfunct.sh
else
    echo "missing file: sharedfuncs"
    exit 1
fi

echo  "Checking to see if Oh-My-ZSH is installed"
shell_check

#Symbolic link dot-config files to user directory
symbolicdot "${FILES[*]}"
#Other dotconfig files with weird paths
ln_files "$HOME"/dmenuExtended_preferences.txt /home/"$USER"/.config/dmenu-extended/config/dmenuExtended_preferences.txt
ln_files "$HOME"/mpv.conf /home/"$USER"/.config/mpv/mpv.conf

#sets up firefox with plugins and such
ln_files "$HOME"/user.js /home/"$USER"/.mozilla/firefox/*.default/user.js
ln_files "$HOME"/twily.vimp /home/"$USER"/.vimperator/colors/twily.vimp

echo "Please visit http://twily.info for more Firefox rice and run vim to install plugins"
echo "Run vim"
