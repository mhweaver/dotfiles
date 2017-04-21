all: install link

link: link-powerline link-tmux link-vim

install: install-powerline install-vim

install-powerline: init-submodules
	cd submodules/powerline; python setup.py build

install-vim: init-submodules

install-bash: FORCE
	./install-bash.sh

link-powerline: FORCE
	stow powerline

link-tmux: FORCE
	stow tmux

link-vim: FORCE
	stow vim

init-submodules:	FORCE
	git submodule update --init --recursive

FORCE:
