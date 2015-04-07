# Path to your oh-my-zsh installation.
export ZSH=/home/ewhal/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, git-extras, python, tmux, docker, vi-mode)

# User configuration

export PATH="/usr/lib/hardening-wrapper/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/opt/opencascade/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# 
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;40;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

alias grep='grep --color=auto'
    alias more='less'
    alias df='df -h'
    alias du='du -c -h'
    alias mkdir='mkdir -p -v'
    alias ping='ping -c 5'
    alias bc='bc -q'
    alias dvtm='DVTM_TERM=rxvt dvtm -M'
    alias cal="cal -3m"
    alias mpdviz="mpdviz -iv wave"
# }}}
#
## New commands  {{{
    alias da='date "+%A, %B %d, %Y [%T]"'
    alias du1='du --max-depth=1'
    alias hist='history | grep'
    alias openports='ss --all --numeric --processes --ipv4 --ipv6'
    alias sf='cls;screenfetch;~/.bin/colors-hex'
    alias sff='cls;sh ~/Div/screenfetch'
    alias scrot="scrot -e 'optipng $f'"
    alias scrotw='sh ~/.bin/scrotw'
    alias fehslide="feh -.zZD5 --keep-zoom-vp -Bblack -^feh"
    alias nightly="firefox-nightly"
    alias tsaver="sh ~/.bin/pipes.x -n 2"
    alias calc="galculator"
# }}}
#
## Privileged access
if [ $UID -ne 0 ]; then
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
fi

#Safety features  {{{
#   alias cp='cp -i'
#   alias mv='mv -i'
#   alias rm='rm -I'
    alias cls=' echo -ne "\033c"'
#}}}

# Make errors tollerant # {{{
    alias :q=' exit'
    alias :Q=' exit'
    alias :x=' exit'
    alias quit=' exit'
    alias cd..='cd ..'
    alias vi='vim'
    alias vmi='vim'
#}}}


alias ncmpcppr='ncmpcpp -h twily'

alias fancy="sh ~/scripts/compton"
alias fortune-send="sh ~/scripts/fortune-send"

# -- Prompt/PS1
autoload -U promptinit
promptinit

autoload -U colors && colors
setopt promptsubst
setopt nonomatch

#PROMPT="%{$fg[red]%}%n%{$reset_color%} %{$fg_no_bold[yellow]%}%~ %{$reset_color%}%# "
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%M %{$fg_no_bold[yellow]%}%~ %{$reset_color%}%# "
#RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
#export PS1=""%robbyrusselOMPT="%{$fg_bold[grey]%}%{$reset_color%}> "
RPROMPT="%{$fg_bold[blue]%}%~%{$reset_color%}"


export PATH=$PATH:/home/ewhal/.bin


#functions
yt() {
    IFS='&' read -r URL LIST <<< "$@"
    mpv $(youtube-dl -g "$URL")
}
desktop() {
    ssh ewhal4@192.168.0.17
}
pi() {
    ssh pi@192.168.0.16
}
fancontrol() {
   sudo /home/ewhal/.fancontrol $1
}

countdown() {
    secs=$(($1 * 60))
    while [ $secs -gt 0 ]; do
        echo -ne "Counting down from $1 minutes, \033[1;31m$secs seconds\033[0m remaining... \033[1;30m(Ctrl+C to Cancel)\033[0m\r"
        sleep 1
        : $((secs--));
    done; echo -e "\n\033[1;30m$(date)\033[1;31m Countdown has finished!\033[0m\n"
}

note() {
    case $@ in
        "-e") vim ~/.note;;
          "") cat ~/.note|less;;
           *) echo -e "$@\n" >> ~/.note
              echo -e "\033[0;37m\"$@\" \033[1;30madded to your notes.\033[0m\n";;
    esac
}

secrets() {
    if [ ! -f ~/.secrets ]; then touch ~/.secrets; fi
    case $@ in
        "-e") cat ~/.secrets|xxd -r -p|base64 -d > ~/secrets.open; rm -f ~/.secrets
              vim ~/secrets.open
              cat ~/secrets.open|base64|xxd -p -c 16 > ~/.secrets; rm -f ~/secrets.open;;
           *) cat ~/.secrets|xxd -r -p|base64 -d|less;;
    esac
}

run_bg() {
    nohup $@ > /dev/null 2>&1 &
}

th() { resize -s $1 $COLUMNS > /dev/null }
tw()  { resize -s $LINES $1 > /dev/null }
td() {
    getwindowgeometry
    cH=$h
    resize -s $1 $COLUMNS > /dev/null
    getwindowgeometry
    nH=`expr $cH - $h`
    xdotool getactivewindow windowmove $x `expr $y + $nH - 24`
}

getwindowgeometry() {
    unset x y w h
    eval $(xwininfo -id $(xdotool getactivewindow) | 
        sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
               -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
               -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
               -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
}

# infinality (Kori)
export INFINALITY_FT_FILTER_PARAMS='25 30 40 30 25'
export INFINALITY_FT_FILTER_PARAMS='15 25 45 25 15'
export INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH=0
export INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH=0
export INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS=true
export INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT=0
export INFINALITY_FT_GAMMA_CORRECTION='0 100'
export INFINALITY_FT_BRIGHTNESS=0
export INFINALITY_FT_CONTRAST=0
export INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH=5
export INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH=0
export INFINALITY_FT_FRINGE_FILTER_STRENGTH=0
export INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH=10
export INFINALITY_FT_STEM_ALIGNMENT_STRENGTH=0
export INFINALITY_FT_STEM_FITTING_STRENGTH=25
export INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE=50
export INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS=true
export INFINALITY_FT_USE_VARIOUS_TWEAKS=true


# Enable Zsh command highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export DEFAULT_USER="ewhal"
