# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

#function zle-line-init() { zle -K vicmd; }

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

bindkey -v

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  #echo "km:$KEYMAP"
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
#if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  #RPS1='$(vi_mode_prompt_info)'
#fi
