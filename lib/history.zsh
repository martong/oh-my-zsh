## Command history configuration
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
# ignore all dups to make hist substring search work nicely.
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
