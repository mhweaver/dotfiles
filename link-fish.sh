#!/bin/bash -x

source link-common.sh

# Link fish config
FISH_DIR=$(pwd)/fish
FISH_CONFIG_DIR=~/.config/fish
link_config $FISH_DIR $FISH_CONFIG_DIR

# Keep the old fish_history
if [ -d ${FISH_CONFIG_DIR}.bak ]; then
	cp ${FISH_CONFIG_DIR}.bak/fish_history $FISH_CONFIG_DIR/fish_history
fi
