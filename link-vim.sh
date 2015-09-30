#!/bin/bash -x

source link-common.sh

# Link vim configs
VIM_RC=$(pwd)/vim/vimrc
GVIM_RC=$(pwd)/vim/gvimrc
VIM_RC_DIR=~
rm -f $VIM_RC_DIR/.vimrc
rm -f $VIM_RC_DIR/.gvimrc
ln -s $VIM_RC $VIM_RC_DIR/.vimrc 
ln -s $GVIM_RC $VIM_RC_DIR/.gvimrc 
