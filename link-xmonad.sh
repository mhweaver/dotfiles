#!/bin/bash -x

source link-common.sh

# Link xmonad config
XMONAD_DIR=$(pwd)/xmonad
XMONAD_CONFIG_DIR=~/.xmonad
link_config $XMONAD_DIR $XMONAD_CONFIG_DIR

