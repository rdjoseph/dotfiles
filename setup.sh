#!/bin/bash
#This script creates symlinks to all the dotfiles 
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.vim ~/.vim 
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.emacs ~/.emacs
cp see_you_space_cowboy.sh ~/see_you_space_cowboy.sh # A symbolic link won't work because there's too many levels of symbolic linking involved
