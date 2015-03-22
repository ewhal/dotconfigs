#!/bin/bash
echo "Please enter your username"
read NAME

echo "Please enter your firefox profile name"
read PROFILE

FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc"
ADDONS="https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://www.eff.org/files/https-everywhere-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/334572/addon-334572-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi https://addons.mozilla.org/firefox/downloads/file/298890/vimperator-3.9-fx.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi"
cwd=$(pwd)

echo "Installing needed packages"
yaourt -S i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcppp dmenu nm-applet vim mpd-git tmux zsh mpc screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr

echo "Installing oh-my-zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

for f in $FILES
do
   ln -fs $(pwd)/$f /home/$NAME/$f
done

ln -fs $(pwd)/mpv.conf /home/$NAME/.config/mpv/mpv.conf
ln -fs $(pwd)/user.js /home/$NAME/.mozilla/firefox/$PROFILE/user.js

echo "Setting up firefox"

for a in $ADDONS
do
    echo "wget $a"
done

firefox *.xpi
rm *.xpi
ln -fs $(pwd)/twily.vimp /home/$NAME/colors/twily.vimp
echo "Please visit twily.info for more Firefox rice and run vim to install plugins"


