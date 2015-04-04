#!/bin/bash
#Variables and such
packages=(package-query yaourt)
FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc "
ADDONS="https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.cdn.mozilla.net/user-media/addons/415846/self_destructing_cookies-0.4.7-fx+an.xpi https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://https-finder.googlecode.com/files/httpsfinder_0.91b.xpi https://addons.mozilla.org/firefox/downloads/latest/6623/addon-6623-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi  https://www.eff.org/files/https-everywhere-latest.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi https://ccd0.github.io/4chan-x/builds/4chan-X.user.js"
USER=$(whoami)
HOME=$(pwd)

#Install Yaourt
if [[ $(pacman -Qs base-devel) == "" ]]; then
  pacman -S base-devel
fi
cd /tmp;
for pkg in "${packages[@]}"
do
    mkdir $pkg
    cd $pkg
    curl -O https://aur.archlinux.org/packages/$(echo $pkg | cut -c 1-2)/$pkg/PKGBUILD
    makepkg -si --noconfirm
    cd ..
    rm -rf $pkg
done


#Packages for rice
echo "Installing needed packages"
yaourt -S i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc network-manager network-manager-applet vim mpv-git tmux zsh mpc screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended

#zsh > bash
echo "Installing oh-my-zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

#change shell
echo "chsh then type in /usr/bin/zsh"
chsh

#link .config files to git repo
for f in $FILES
do
   ln -fs $HOME/$f /home/$NAME/$f
done

ln -fs $HOME/mpv.conf /home/$NAME/.config/mpv/mpv.conf
ln -fs $HOME/user.js /home/$NAME/.mozilla/firefox/*.default/user.js
ln -fs $HOME/dmenuExtended_preferences.txt /home/$NAME/.config/dmenu-extended/config/dmenuExtended_preferences.txt

echo "Setting up firefox"

mkdir extensions
cd extensions
for a in $ADDONS
do
    firefox $a
done
cd ..

ln -fs $HOME/twily.vimp /home/$NAME/.vimperator/colors/twily.vimp
echo "Please visit twily.info for more Firefox rice and run vim to install plugins"


