HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt autocd
setopt HIST_IGNORE_ALL_DUPS

autoload compinit; compinit
_comp_options+=(globdots) # with hidden files

function precmd {
  source $ZDOTDIR/aliases
  source $ZDOTDIR/gitaliases
}

# custom key bindings
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^d "tmux-sessionizer $HOME/.dotfiles\n"

if [[ $(uname) == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# plugins
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/spaceship/spaceship.zsh
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
fpath=($ZDOTDIR/plugins/pure $fpath)

autoload -U promptinit; promptinit
prompt pure
