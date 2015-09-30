all: fish powerline tmux vim

fish: FORCE
	./link-fish.sh

powerline: FORCE
	./link-powerline.sh

tmux: FORCE
	./link-tmux.sh

vim: FORCE
	./link-vim.sh

FORCE:
