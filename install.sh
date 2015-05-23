#!/bin/bash
#Arrays and such to be used throughout the program
ADDONS=( https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.cdn.mozilla.net/user-media/addons/415846/self_destructing_cookies-0.4.7-fx+an.xpi https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://https-finder.googlecode.com/files/httpsfinder_0.91b.xpi https://addons.mozilla.org/firefox/downloads/latest/6623/addon-6623-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi  https://www.eff.org/files/https-everywhere-latest.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi https://ccd0.github.io/4chan-x/builds/4chan-X.user.js https://nebukazar.github.io/OneeChan/builds/OneeChan.user.js )
FILES=( .zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc  )
USER=$(whoami)
HOME=$(pwd)
ARCH=( i3-wm i3lock i3status conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc networkmanager network-manager-applet ladspa-bs2b vim mpv-git tmux zsh screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended numix-themes gtk-theme-flatstudio numix-icon-theme-git thunar lxappearance tor unbound dnscrypt-proxy)
NPM=( bower grunt-cli yo generator-angular-fullstack generator-angular )
GENTOO=( i3 i3lock i3status conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc networkmanager network-manager-applet ladspa-bs2b vim mpv tmux zsh screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended numix-themes gtk-theme-flatstudio numix-icon-theme-git thunar lxappearance tor unbound dnscrypt-proxy)

if [[ -f $HOME/sharfunct.sh ]]; then
    source sharfunct.sh
else
    echo "missing file: sharedfuncs"
    exit 1
fi

if [[ -f /etc/arch-release ]]; then
    echo "Updating"
    update_arch
    echo "Checking to see if programs need to be installed to continue"
    check_installed_arch "${ARCH[*]}"
    echo "Installing packages"
    install_arch "${INSTALL[*]}"
elif [[ -f /etc/gentoo-release ]]; then
    echo "Updating"
    update_gentoo
    echo "Checking to see if programs need to be installed to continue"
    check_installed_gentoo "${GENTOO[*]}"
    echo "Installing packages"
    install_gentoo "${INSTALL[*]}"
    if [[ ! -f /usr/bin/systemd ]]; then
        emerge -av systemd
    fi
else
    echo "Unsupported OS"
    exit 1
fi

#Sets up oh-my-zsh and ZSH
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
#firefox_addons "${ADDONS[*]}"
firefox "${ADDONS[@]}"

#Check and install npm packages
npm_checkinstalled "${NPM[*]}"

#setup unbound and dnscrypt
#unbound_dnscrypt_setup

#setup tor
#setup_tor

echo "Please visit http://twily.info for more Firefox rice and run vim to install plugins"
echo "Run vim"
