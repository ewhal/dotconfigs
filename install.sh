#!/bin/bash
#Arrays and such to be used throughout the program
ADDONS="https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.cdn.mozilla.net/user-media/addons/415846/self_destructing_cookies-0.4.7-fx+an.xpi https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://https-finder.googlecode.com/files/httpsfinder_0.91b.xpi https://addons.mozilla.org/firefox/downloads/latest/6623/addon-6623-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi  https://www.eff.org/files/https-everywhere-latest.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi https://ccd0.github.io/4chan-x/builds/4chan-X.user.js https://nebukazar.github.io/OneeChan/builds/OneeChan.user.js"
FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc "
USER=$(whoami)
HOME=$(pwd)
INSTALL=()
PROGRAMS="i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc networkmanager network-manager-applet ladspa-bs2b vim mpv-git tmux zsh mpc screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended numix-themes gtk-theme-flatstudio numix-icon-theme-git thunar lxappearance"

#Checks to see if packages are installed
function is_installed() {
    if [[ $(pacman -Qs $1) == "" ]];then
        return 1
    else
        return 0
    fi
}
#checks to see if package-query and yaourt are installed
function AUR() {
    if [ ! is_installed package_query || ! is_installed yaourt ] ;then
        if ! is_installed base-devel ; then
            pacman -S base-devel
        fi
        cd /tmp;
        mkdir $1
        cd $1
        curl -O https://aur.archlinux.org/packages/$(echo $1 | cut -c 1-2)/$1/1BUILD
        makepkg -si --noconfirm
        cd ..
        rm -rf $1
    else
        yaourt -S $1
    fi
}
#checks to see if a file or directory already exists
function is_FileOrDirectory() {
    if [[ ! -e $1 && ! -L $1 ]]; then
        return 0
    else
        return 1
    fi
}
function ln_files() {
    if is_FileOrDirectory $2; then
         ln -fs $1 $2
    else
        echo "$2 already exists"
    fi
}
function echo_fail {
    printf "${1} \e[31m✘ "
    echo -e "\033[0m"
}
function echo_pass {
    printf "${1} \e[32m✔ "
    echo -e "\033[0m"
}

echo "Checking to see if programs need to be installed to continue"
for pkg in $PROGRAMS
do
    if is_installed $pkg; then
        echo_pass $pkg
    else
        echo_fail $pkg
        INSTALL+=($pkg)
    fi
done

for pkg in "${INSTALL[@]}"
do
    AUR $pkg
done

#Sets up oh-my-zsh and ZSH

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    if is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
        echo_fail "oh-my-zsh not found"
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    else
        echo_pass "oh-my-zsh installed"
    fi
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    if  is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
        echo_fail "oh-my-zsh not found"
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        echo "chsh then type in /usr/bin/zsh"
        chsh
    else
        echo_pass "oh-my-zsh installed"
    fi
else
    echo "Error unknown Shell"
fi

#Symbolic link dot-config files to user directory
for f in $FILES
do
    if is_FileOrDirectory /home/$USER/$f; then
         ln -fs $HOME/$f /home/$USER/$f
        echo_fail $f
    else
        echo_pass $f
    fi
done
ln_files $HOME/dmenuExtended_preferences.txt /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
ln_files $HOME/mpv.conf /home/$USER/.config/mpv/mpv.conf
#sets up firefox with plugins and such
ln_files $HOME/user.js /home/$USER/.mozilla/firefox/*.default/user.js
ln_files $HOME/twily.vimp /home/$USER/.vimperator/colors/twily.vimp

#install FF addons
#for a in $ADDONS
#do
#    firefox $a
#done


NPM="bower grunt-cli yo generator-angular-fullstack generator-angular"
#installs npm packages
for n in $NPM
do
    if is_FileOrDirectory /usr/lib/node_modules/$n; then
        echo_fail $n
        sudo npm install -g $n
    else
       echo_pass $n
    fi
done

echo "Please visit http://twily.info for more Firefox rice and run vim to install plugins"
echo "Please do systemctl enable mongodb.service and please run vim"
