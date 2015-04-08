#!/bin/bash
#Checks to see if packages are installed
function is_installed() {
    if pacman -Q $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}
function update() {
    pacman -Syy
}
#checks to see if package-query and yaourt are installed
function AUR() {
    for pkg in $1
    do
        if is_installed package_query || is_installed yaourt  ;then
            yaourt -S --noconfirm $pkg
            echo_pass $pkg
        else
            if ! is_installed base-devel ; then
                pacman -S base-devel
            fi
            cd /tmp;
            mkdir $pkg
            cd $pkg
            curl -O https://aur.archlinux.org/packages/$(echo $pkg | cut -c 1-2)/$pkg/1BUILD
            makepkg -si --noconfirm
            cd ..
            rm -rf $pkg

        fi
    done
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
        echo_fail $2
        ln -fs $1 $2
    else
        echo_pass $2
    fi
}

function echo_fail {
    printf "${1} \e[31m[✘] "
    echo -e "\033[0m"
}

function echo_pass {
    printf "${1} \e[32m[✔] "
    echo -e "\033[0m"
}

function check_installed() {
    for pkg in $1
    do
        if is_installed $pkg; then
            echo_pass $pkg
        else
            echo_fail $pkg
            INSTALL+=("$pkg")
        fi
    done
}

function shell_check() {
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        if is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
            echo_fail "oh-my-zsh not found"
            zsh_install
        else
            echo_pass "oh-my-zsh installed"
        fi
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        # assume Bash
        if  is_FileOrDirectory /home/$USER/.oh-my-zsh ; then
            echo_fail "oh-my-zsh not found"
            zsh_install
            echo "chsh then type in /usr/bin/zsh"
            chsh
        else
            echo_pass "oh-my-zsh installed"
        fi
    else
        echo "Error unknown Shell"
    fi
}

function zsh_install() {
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
}

function symbolicdot() {
    for f in $1
    do
        if is_FileOrDirectory /home/$USER/$f; then
            ln -fs $HOME/$f /home/$USER/$f
            echo_fail $f
        else
            echo_pass $f
        fi
    done
}

function npm_checkinstalled() {
    for n in $1
    do
        if is_FileOrDirectory /usr/lib/node_modules/$n; then
            echo_fail $n
            sudo npm install -g $n
        else
            echo_pass $n
        fi
    done
    system_ctl mongodb
}

function firefox_addons() {
    for a in $1
    do
        firefox $a
    done
}

function system_ctl() {
    systemctl enable $1
    systemctl start $1
}
function setup_tor() {
    echo lel
}
function setup_unbound_dnscrypt() {
    ln_files $HOME/dnscrypt-config /etc/conf.d/dnscrypt-config
    ln_files $HOME/dnscrypt-proxy /etc/conf.d/dnscrypt-proxy
    ln_files $HOME/unbound /etc/unbound
    ln_files $HOME/resolv.conf /etc/resolv.conf
    chattr +i /etc/resolv.conf
    system_ctl unbound
    system_ctl dnscrypt-proxy
}
