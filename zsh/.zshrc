source $HOME/repos/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
#antigen bundle globalias
antigen bundle common-aliases
antigen bundle dirhistory

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

antigen bundle Tarrasch/zsh-command-not-found
#antigen bundle clvv/fasd

antigen bundle psprint/zsh-cmd-architect

antigen bundle MichaelAquilina/zsh-you-should-use

antigen bundle chrissicool/zsh-256color

antigen bundle agkozak/zsh-z

antigen bundle mhweaver/zsh-toggle-alias

antigen bundle KyleChamberlin/zsh_maven_plugin
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle zsh-users/zsh-completions
antigen bundle mhweaver/zsh-abduco-completion

# Load the theme.
antigen theme agnoster

# Tell Antigen that you're done.
antigen apply

export EDITOR=vim
export DVTM_PAGER='less -R'
export DVTM_EDITOR='vis'
export SHELL=/usr/bin/zsh
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

alias f='fasd -f'
alias v='f -e vim'
alias gdiff='git diff --word-diff'
alias surf='xembed -e surf'
alias st='xembed -w st'
#
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ARBFUND/mweaver/.sdkman"
[[ -s "/home/ARBFUND/mweaver/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ARBFUND/mweaver/.sdkman/bin/sdkman-init.sh"
