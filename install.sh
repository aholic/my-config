#!/bin/bash

cp .bashrc ~/ -vf
cp .inputrc ~/ -vf
cp .screenrc ~/ -vf

cp .vimrc ~/ -vf
cp .gitconfig ~/ -vf

if [ ! -d ~/.vim/syntax ]
  then
    mkdir -vp ~/.vim/syntax
fi
cp c.vim ~/.vim/syntax -vf

