#!/bin/bash -x

source link-common.sh

# Link powerline config
POWERLINE_DIR=$(pwd)/powerline
POWERLINE_CONFIG_DIR=~/.config/powerline
link_config $POWERLINE_DIR $POWERLINE_CONFIG_DIR
