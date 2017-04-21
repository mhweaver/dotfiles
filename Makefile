all: install link

link: link-powerline link-tmux link-vim

install: install-powerline install-vim

install-powerline: init-submodules
	cd submodules/powerline; python setup.py build

install-vim: init-submodules

install-bash: FORCE
	./install-bash.sh

link-powerline: FORCE
	./link-powerline.sh

link-tmux: FORCE
	./link-tmux.sh

link-vim: FORCE
	stow vim

init-submodules:	FORCE
	git submodule update --init --recursive

FORCE:
