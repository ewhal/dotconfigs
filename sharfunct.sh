#!/bin/bash
#Checks to see if packages are installed
function is_installed() {
    if $OS == "ARCH"; then

        if pacman -Q $1 &> /dev/null; then
            return 0
        else
            return 1
        fi
    elif $OS == "GENTOO"; then
        if emerge  $1 &> /dev/null; then
            return 0
        else
            return 1
        fi
    else
        echo "Error unsupported OS"
        exit 1
    fi
}

function update()  {
    if $OS == "ARCH"; then
        pacman -Syy
    elif $OS == "GENTOO"; then
        emerge -av @world
    else
        echo "Error unsupported OS"
        exit 1
    fi
}

#checks to see if package-query and yaourt are installed
function install() {
    for pkg in $1
    do
        if $OS == "ARCH"; then
            if is_installed package_query || is_installed yaourt  ;then
                if ! is_installed base-devel ; then
                    pacman -S base-devel
                fi
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
        elif $OS == "GENTOO"; then
            emerge -av $pkg
        else
            echo "Error unsuported OS"
            exit 1
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
    init mongodb
}

function setup_tor() {
    echo "Setting up TOR"
    ln_files
    init tor
}

function setup_unbound_dnscrypt() {
    ln_files $HOME/dnscrypt-config /etc/conf.d/dnscrypt-config
    ln_files $HOME/dnscrypt-proxy /etc/conf.d/dnscrypt-proxy
    ln_files $HOME/unbound /etc/unbound
    ln_files $HOME/resolv.conf /etc/resolv.conf
    chattr +i /etc/resolv.conf
    init unbound
    init dnscrypt-proxy
}

function detect_os() {
    if ! is_FileOrDirectory /etc/arch-release; then
        OS="ARCH"
        echo $OS
        check_init
        echo "Updating"
        update
        echo "Checking to see if programs need to be installed to continue"
        check_installed $ARCH
        echo "Installing packages"
        install $INSTALL
        return 0
    elif ! is_FileOrDirectory /etc/gentoo-release; then
        OS="GENTOO"
        echo $OS
        check_init
        echo "Updating"
        update
        echo "Checking to see if programs need to be installed to continue"
        check_installed $GENTOO
        echo "Installing packages"
        install $INSTALL
        return 0
    else
        echo "Unsuported OS"
        exit 1
    fi
}

function is_running() {
    if $OS == "ARCH"; then
        if $(systemctl is-active $1) == "active"; then
            return 0
        elif $(systemctl is-active $1) == "inactive"; then
            return 1
        else
            echo "Error"
            exit 1
        fi
    elif $OS == "GENTOO"; then
        if $INITSYS == "systemd"; then
            if $(systemctl is-active $1) == "active"; then
                return 0
            elif $(systemctl is-active $1) == "inactive"; then
                return 1
            else
                echo "Error init system not supported or found"
                exit 1
            fi
        elif $INITSYS == "sysv"; then
            if $(ps -ef | grep -v grep | grep $service | wc -l) > 0; then
                return 0
            else
                return 1
            fi
        fi
    else
        echo "Error init system not supported or found"
    fi
}

function check_init() {
    if $(ps '1' | grep -o /sbin/init) == "/sbin/init"; then
        INITSYS="systemd"
        echo $INITSYS
    elif $(ps '1' | grep -o init) == "init"; then
        INITSYS="sysv"
    else
        echo "Init system not supported"
        exit 1
    fi
}
function init() {
    if $OS == "ARCH"; then
        if is_running $1; then
            echo "Error $1 is running"
        else
            systemctl enable $1
            systemctl start $1
        fi
    elif $OS == "GENTOO"; then
        if $INITSYS == systemd; then
            if is_running $1; then
                echo "Error $1 is running"
            else
                systemctl enable $1
                systemctl start $1
            fi
        elif $INITSYS == "sysv"; then
            if is_running $1; then
                echo "Error $1 is running"
            else
                rc-update add $1 default
                /etc/init.d/$1 start
            fi
        else
            echo "Error init system not supported or found"
            exit 1
        fi
    else
        echo "Error init system not supported or found"
        exit 1
    fi
}


