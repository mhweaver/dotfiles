#!/bin/bash -x

if [ ! -d ~/.config ]; then
	mkdir ~/.config
fi

function link_config {
	SRC_CONFIG_DIR=$1 # The config dir in this repo (e.g., fish)
	CONFIG_DIR=$2 # The where the links should be
	if [ -d $CONFIF_DIR ]; then
		rm -r ${CONFIG_DIR}.bak || true
		mv $CONFIG_DIR ${CONFIG_DIR}.bak
		mkdir $CONFIG_DIR
	fi

	for link in $(ls $SRC_CONFIG_DIR); do
		ln -s ${SRC_CONFIG_DIR}/${link} ${CONFIG_DIR}/${link}
	done
}

# Link fish config
FISH_DIR=$(pwd)/fish
FISH_CONFIG_DIR=~/.config/fish
link_config $FISH_DIR $FISH_CONFIG_DIR

# Link powerline config
POWERLINE_DIR=$(pwd)/powerline
POWERLINE_CONFIG_DIR=~/.config/powerline
link_config $POWERLINE_DIR $POWERLINE_CONFIG_DIR

# Link tmux config
TMUX_CONFIG=$(pwd)/tmux.conf
TMUX_CONFIG_DIR=~
rm -f ${TMUX_CONFIG_DIR}/.tmux.conf
ln -s $TMUX_CONFIG $TMUX_CONFIG_DIR/.tmux.conf

# Link tmuxinator config
TMUXINATOR_CONFIG=$(pwd)/tmuxinator
TMUXINATOR_CONFIG_DIR=~/.tmuxinator
link_config $TMUXINATOR_CONFIG $TMUXINATOR_CONFIG_DIR
