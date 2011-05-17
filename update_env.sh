#!/bin/sh
for x in screenrc tmux.conf vimrc zshrc; do wget -O ".$x" "https://github.com/htr/remote-env/raw/master/$x"; done
