#!/bin/bash
echo Please enter your username
read NAME
FILES=".zshrc .Xresources .vimrc .weechat .i3 .tmux.conf .bin .xinitrc .ncmpcpp .conkyrc .mpd"
cwd=$(pwd)
yaourt -S i3 conky powerline-fonts-git rxvt-unicode mpd ncmpcppp dmenu nm-applet vim mpd-git tmux zsh mpc
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
for f in $FILES
do
   ln -fs $(pwd)/$f /home/$NAME/$f
done
ln -fs $(pwd)/mpv.conf /home/$NAME/.config/mpv/mpv.conf


