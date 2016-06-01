if [ ! (echo $TERM | grep "256color\$") ]
	set -x TERM xterm-256color
end
set -x EDITOR /usr/bin/vim
set -x SHELL /usr/bin/fish
tput smkx ^/dev/null
function fish_enable_keypad_transmit --on-event fish_postexec
    tput smkx ^/dev/null
end

function fish_disable_keypad_transmit --on-event fish_preexec
    tput rmkx ^/dev/null
end
# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/dist-packages/powerline/bindings/fish"
set -x PATH ~/dotfiles/.extern/powerline/scripts $PATH
set -x PYTHONPATH ~/dotfiles/.extern/powerline/:$PYTHONPATH
#set -x POWERLINE_COMMAND ~/dotfiles/.extern/powerline/scripts/powerline-daemon
set fish_function_path $fish_function_path "~/dotfiles/.extern/powerline/powerline/bindings/fish"
source ~/dotfiles/.extern/powerline/powerline/bindings/fish/powerline-setup.fish
powerline-setup

source ~/dotfiles/env.fish

eval (direnv hook fish)
