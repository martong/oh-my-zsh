bindkey -v

function zle-line-init zle-keymap-select {
	VIM_NORMAL="%{$fg_bold[white]%} [% normal]%  %{$reset_color%}"
	VIM_INSERT="%{$fg_bold[red]%} [% INSERT]%  %{$reset_color%}"
	XXX="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
	PROMPT=$'$XXX%{$fg_bold[green]%}%m %{$fg[blue]%}%D{[%H:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info2)\n%{$fg[blue]%}->%(?.%{$fg[green]%}.%{$fg[red]%}) %#%{$reset_color%} '
	zle reset-prompt
}


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
