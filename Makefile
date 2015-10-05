all: install link

link: link-fish link-powerline link-tmux link-vim

install: install-powerline install-vim

install-powerline: FORCE
	./install-powerline.sh

install-vim: FORCE
	./install-vim.sh

link-fish: FORCE
	./link-fish.sh

link-powerline: FORCE
	./link-powerline.sh

link-tmux: FORCE
	./link-tmux.sh

link-vim: FORCE
	./link-vim.sh

FORCE:
