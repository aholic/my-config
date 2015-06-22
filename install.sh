#!/bin/bash

cp .bashrc ~/ -vf
cp .inputrc ~/ -vf
cp .screenrc ~/ -vf
cp .vimrc ~/ -vf
cp .dircolors ~/ -f

source ~/.bashrc
source ~/.inputrc

rm ~/.vim -rf
cp .vim ~/.vim

