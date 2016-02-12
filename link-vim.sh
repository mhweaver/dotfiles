#!/bin/bash -x

source link-common.sh

# Set up location vars
VIM_RC_DIR=$HOME
if [ "$1" = "lite" ]; then
	VIM_RC=$(pwd)/vim/vimrc-base
	GVIM_RC=$(pwd)/vim/gvimrc
else
	VIM_RC=$(pwd)/vim/vimrc
	GVIM_RC=$(pwd)/vim/gvimrc
fi

# Link vim configs
rm -f $VIM_RC_DIR/.vimrc
rm -f $VIM_RC_DIR/.gvimrc
ln -s $VIM_RC $VIM_RC_DIR/.vimrc 
ln -s $GVIM_RC $VIM_RC_DIR/.gvimrc 
