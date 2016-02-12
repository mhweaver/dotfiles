#!/bin/bash

if [ -z ${DOTFILES_DIR+x} ]; then
	echo "source $PWD/env.sh" >> $HOME/.bashrc
	echo "source $PWD/env.sh" >> $HOME/.profile
fi
