set -x EDITOR /usr/bin/vim
set -x SHELL /usr/bin/fish
# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/dist-packages/powerline/bindings/fish"
set -x PATH ~/configs/.extern/powerline/scripts $PATH
#set -x POWERLINE_COMMAND ~/configs/.extern/powerline/scripts/powerline-daemon
set fish_function_path $fish_function_path "~/configs/.extern/powerline/powerline/bindings/fish"
source ~/configs/.extern/powerline/powerline/bindings/fish/powerline-setup.fish
powerline-setup
