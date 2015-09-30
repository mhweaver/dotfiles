#!/bin/bash -x

source link-common.sh

# Link tmux config
TMUX_CONFIG=$(pwd)/tmux.conf
TMUX_CONFIG_DIR=~
rm -f ${TMUX_CONFIG_DIR}/.tmux.conf
ln -s $TMUX_CONFIG $TMUX_CONFIG_DIR/.tmux.conf

# Link tmuxinator config
TMUXINATOR_CONFIG=$(pwd)/tmuxinator
TMUXINATOR_CONFIG_DIR=~/.tmuxinator
link_config $TMUXINATOR_CONFIG $TMUXINATOR_CONFIG_DIR
