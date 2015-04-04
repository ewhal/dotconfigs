#!/bin/bash
#Variables and such
packages=(package-query yaourt)
FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc "
ADDONS="https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.cdn.mozilla.net/user-media/addons/415846/self_destructing_cookies-0.4.7-fx+an.xpi https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://https-finder.googlecode.com/files/httpsfinder_0.91b.xpi https://addons.mozilla.org/firefox/downloads/latest/6623/addon-6623-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi  https://www.eff.org/files/https-everywhere-latest.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi https://ccd0.github.io/4chan-x/builds/4chan-X.user.js https://nebukazar.github.io/OneeChan/builds/OneeChan.user.js"
USER=$(whoami)
HOME=$(pwd)
NPM="bower grunt-cli yo generator-angular-fullstack generator-angular"

#Install Yaourt
if [[ $(pacman -Qs packae-query) == ""   &&   $(pacman -Qs yaourt) ==  "" ]]; then
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
fi

#Packages for rice
echo "Installing needed packages"
yaourt -S i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc networkmanager network-manager-applet ladspa-bs2b vim mpv-git tmux zsh mpc screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended numix-themes gtk-theme-flatstudio numix-icon-theme-git thunar lxappearance

#zsh > bash
echo "Installing oh-my-zsh"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    if [ ! -d /home/$USER/.oh-my-zsh/ ]; then
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    fi
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
   # assume Bash
    if [ ! -d /home/$USER/.oh-my-zsh ]; then
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    fi
    echo "chsh then type in /usr/bin/zsh"
    chsh
else
   echo "Fix your god damn shell"
fi

#link .config files to git repo
for f in $FILES
do
    if [[ ! -e /home/$USER/$f && ! -L /home/$USER/$f ]]; then
         ln -fs $HOME/$f /home/$USER/$f
    fi
done

if [[ ! -e /home/$USER/.config/mpv/mpv.conf && ! -L /home/$USER/.config/mpv/mpv.conf ]]; then
    ln -fs $HOME/mpv.conf /home/$USER/.config/mpv/mpv.conf
fi
if [[ ! -e /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt && ! -L /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt ]]; then
    ln -fs $HOME/dmenuExtended_preferences.txt /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
fi

read -p "Do you wish to setup firefox? type y or n " ANSWER

if [[ $ANSWER = "y" ]]; then
    if [[ ! -e  /home/$USER/.mozilla/firefox/*.default/user.js &&  ! -L  /home/$USER/.mozilla/firefox/*.default/user.js ]]; then
        ln -fs $HOME/user.js /home/$USER/.mozilla/firefox/*.default/user.js
    fi

    for a in $ADDONS
    do
        firefox $a
    done

    if [ ! -d /home/$USER/.vimperator/colors ]; then
        mkdir -p /home/$USER/.vimperator/colors
        if [[ ! -e /home/$USER/.vimperator/colors/twily.vimp && ! -L /home/$USER/.vimperator/colors/twily.vimp ]]; then
            ln -fs $HOME/twily.vimp /home/$USER/.vimperator/colors/twily.vimp
        fi

    elif [ -d /home/$USER/.vimperator/colors]; then
        if [[ ! -e /home/$USER/.vimperator/colors/twily.vimp && ! -L /home/$USER/.vimperator/colors/twily.vimp ]]; then
            ln -fs $HOME/twily.vimp /home/$USER/.vimperator/colors/twily.vimp
        fi
    fi
    echo "Please visit twily.info for more Firefox rice and run vim to install plugins"
elif [[ $ANSWER = "n" ]]; then
    echo "Please visit twily.info for more Firefox rice and run vim to install plugins"
fi

for n in $NPM
do
    if [[ ! -e /usr/lib/node_modules/$n ]]; then
        sudo npm install -g $n
    else
        echo "$n is already installed"
    fi
done

echo "Please do systemctl enable mongodb.service and please run vim"

