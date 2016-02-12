#!/bin/bash

if [ -z ${DOTFILES_DIR+x} ]; then
	echo "\nsource $PWD/env.sh" >> $HOME/.bashrc
	echo "\nsource $PWD/env.sh" >> $HOME/.profile
fi
