all: install link

link: link-fish link-powerline link-tmux link-vim

install: FORCE
	./install.sh

link-fish: FORCE
	./link-fish.sh

link-powerline: FORCE
	./link-powerline.sh

link-tmux: FORCE
	./link-tmux.sh

link-vim: FORCE
	./link-vim.sh

FORCE:
