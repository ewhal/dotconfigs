#!/bin/bash
#Arrays and such to be used throughout the program
ADDONS="https://addons.mozilla.org/firefox/downloads/file/161685/greasemonkey-0.9.22-fx.xpi https://addons.cdn.mozilla.net/user-media/addons/415846/self_destructing_cookies-0.4.7-fx+an.xpi https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi https://https-finder.googlecode.com/files/httpsfinder_0.91b.xpi https://addons.mozilla.org/firefox/downloads/latest/6623/addon-6623-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/953/addon-953-latest.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi  https://www.eff.org/files/https-everywhere-latest.xpi https://github.com/RequestPolicyContinued/requestpolicy/releases/download/v1.0.beta8.2/requestpolicy-1-0-beta8-2.xpi https://ccd0.github.io/4chan-x/builds/4chan-X.user.js https://nebukazar.github.io/OneeChan/builds/OneeChan.user.js"
FIREFOX="/home/$USER/.mozilla/firefox/*.default/user.js /home/$USER/.vimperator/colors/twily.vimp"
OTHERFIREFOX="$HOME/user.js  $HOME/twily.vimp "
OTHERFILES="/home/$USER/.config/mpv/mpv.conf /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt "
OTHERDOTCONFIGS="$HOME/mpv.conf $HOME/dmenuExtended_preferences.txt"
FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd .vimperatorrc "
USER=$(whoami)
HOME=$(pwd)
INSTALL=()
PROGRAMS="package-query yaourt i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcpp mpc networkmanager network-manager-applet ladspa-bs2b vim mpv-git tmux zsh mpc screenfetch speedtest-cli scrot  xfce4-screenshooter python2-potr youtube-dl firefox zsh-syntax-highlighting pulseaudio pavucontrol ttf-opensans ctags dmenu-extended numix-themes gtk-theme-flatstudio numix-icon-theme-git thunar lxappearance"
NPM="bower grunt-cli yo generator-angular-fullstack generator-angular"

#Installs all of the packages that I use
function is_installed() {
    if [[ $(pacman -Qs $1) == "" ]];then
        return 1
    else
        return 0
    fi
}

function AUR() {
    if [[$(pacman -Qs package_query) == "" || $(pacman -Qs yaourt) == "" ]];then
        if [[ $(pacman -Qs base-devel) == "" ]]; then
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

function is_FileOrDirectory() {
    if [[ ! -e $1 && ! -L $1 ]]; then
        return 0
    else
        return 1
    fi

}

echo "Checking to see if programs need to be installed to continue"
for pkg in $PROGRAMS
do
    if is_installed $pkg; then
        echo "$pkg is installed"
    else
        if $pkg == package_query || $pkg == yaourt; then
            echo "Installing $pkg"
            aur $pkg
        else
            echo "$pkg isn't installed"
            INSTALL+=($pkg)

        fi
    fi
done

for pkg in "${INSTALL[@]}"
do
    aur $pkg
done

#Sets up oh-my-zsh and ZSH
echo "Installing oh-my-zsh"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    if is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    fi
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    if  is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    fi
    echo "chsh then type in /usr/bin/zsh"
    chsh
else
    echo "Error unknown Shell"
fi

#Symbolic link dot-config files to user directory
for f in $FILES
do
    if is_FileOrDirectory /home/$USER/$f; then
         ln -fs $HOME/$f /home/$USER/$f
    else
        echo "$f already exists"
    fi
done

for x in $OTHERFILES
do
    for y in $OTHERDOTCONFIGS
    do
         if is_FileOrDirectory $x; then
            ln -fs $HOME/$y $x
        else
            echo "$1 already exists"
        fi
    done
done

#sets up firefox with plugins and such
read -p "Do you wish to setup firefox? type y or n " ANSWER

if [[ $ANSWER = "y" ]]; then


    for x in $FIREFOX
    do
        for y in $OTHERFIREFOX
        do
             if is_FileOrDirectory $x; then
                ln -fs $HOME/$y $x
            else
                echo "$1 already exists"
            fi
        done
    done

    for a in $ADDONS
    do
        firefox $a
    done

    echo "Please visit http://twily.info for more Firefox rice and run vim to install plugins"
elif [[ $ANSWER = "n" ]]; then
    echo "Please visit http://twily.info for more Firefox rice and run vim to install plugins"
fi

#installs npm packages
for n in $NPM
do
    if is_FileOrDirectory /usr/lib/node_modules/$n; then
        sudo npm install -g $n
    else
        echo "$n is already installed"
    fi
done

echo "Please do systemctl enable mongodb.service and please run vim"

