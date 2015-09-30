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

