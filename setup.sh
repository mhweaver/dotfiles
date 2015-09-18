#!/bin/bash -x

if [ ! -d ~/.config ]; then
	mkdir ~/.config
fi

# Link fish config
FISH_DIR=$(pwd)/fish
if [ -d ~/.config/fish ]; then
	# If the dir already exists, make a backup
	rm -r ~/.config/fish.bak || true
	mv ~/.config/fish ~/.config/fish.bak
	mkdir ~/.config/fish
fi
# Link everything in $FISH_DIR to ~/.config/fish
for link in $(ls $FISH_DIR); do
	ln -s ${FISH_DIR}/${link} ~/.config/fish/${link}
done
