export EDITOR=vim
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
alias ls='ls --color=auto'
alias yolo='sudo pacman -Syyuu'
alias gpp='g++ -Wall -pedantic'
youtube() {
    mpv $(youtube-dl -g "$@")
}

server-info() {
                curl -s -I $@ | grep Server
}
genpwd() {
        local l=$1
        [ "$l" == "" ] && l=20
            base64 < /dev/urandom | dd count=${l} bs=1 2>/dev/null; echo;
}
alias py='python'
alias py2='python2'
alias xip='hostname --ip-address'
alias l.='ls -d .* --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias skype="XLIB_SKIP_ARGB_VISUALS=1 LD_PRELOAD=/usr/lib/v4lcompact.so QT_PLUGIN_PATH=/usr/lib32/qt4/plugins /usr/bin/skype "
alias ss13='WINEARCH=win32 WINEPREFIX=/home/ewhal4/.wine_ss13/ wine "C:\Program Files\BYOND\bin\byond.exe"'
alias battlenet='WINEARCH=win32 WINEPREFIX=/home/ewhal4/.wine_ss13/ wine "C:\Program Files\Battle.net\Battle.net Launcher.exe"'
alias battlenet64='WINEARCH=win64 WINEPREFIX=/home/ewhal4/.wine/ wine "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe"'

