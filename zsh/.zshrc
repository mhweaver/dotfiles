source $HOME/repos/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

antigen bundle psprint/zsh-cmd-architect

antigen bundle MichaelAquilina/zsh-you-should-use

antigen bundle chrissicool/zsh-256color

antigen bundle agkozak/zsh-z

antigen bundle mastern2k3/taskbook-zsh-plugin

antigen bundle KyleChamberlin/zsh_maven_plugin
antigen bundle lukechilds/zsh-better-npm-completion
# Load the theme.
antigen theme agnoster

# Tell Antigen that you're done.
antigen apply
