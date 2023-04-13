. /usr/local/opt/asdf/libexec/asdf.sh
source $HOME/repos/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
# antigen bundle lein
antigen bundle command-not-found
#antigen bundle globalias
antigen bundle common-aliases
antigen bundle dirhistory

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

#antigen bundle clvv/fasd

antigen bundle webyneter/docker-aliases.git
# antigen bundle sroze/docker-compose-zsh-plugin

antigen bundle MichaelAquilina/zsh-you-should-use

antigen bundle chrissicool/zsh-256color

antigen bundle agkozak/zsh-z

antigen bundle mhweaver/zsh-toggle-alias

antigen bundle mafredri/zsh-async

antigen bundle jreese/zsh-titles

#antigen bundle mattbangert/kubectl-zsh-plugin
antigen bundle Dbz/kube-aliases

antigen bundle KyleChamberlin/zsh_maven_plugin
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle zsh-users/zsh-completions
antigen bundle mhweaver/zsh-abduco-completion
antigen bundle jeffreytse/zsh-vi-mode

# Load the theme.
#antigen theme agnoster
#antigen theme denysdovhan/spaceship-prompt
#SPACESHIP_TIME_SHOW=true
#SPACESHIP_DIR_TRUNC=4
#SPACESHIP_DIR_TRUNC_REPO=false
#SPACESHIP_DIR_TRUNC_PREFIX='…/'
eval "$(starship init zsh)"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fig/bin:$PATH"

export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"

export CLOUDSDK_PYTHON="$(brew --prefix)/opt/python@3.8/libexec/bin/python"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mweaver/.sdkman"
[[ -s "/Users/mweaver/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mweaver/.sdkman/bin/sdkman-init.sh"

if type brew &>/dev/null; then
	  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

	    autoload -Uz compinit
		  compinit
fi

export PATH="/usr/local/sbin:$PATH"
