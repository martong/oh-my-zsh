source ~/.zsh/git-prompt/zshrc.sh

# This function is a workaround to a strange zsh bug with multi-line
# prompts and vi-mode (zle reset-prompt)
function padding() {
	local gitPrompt=${1}
	local pwdsize=${#${(%):-%m %D{[%H:%M:%S]} [%~]}}

	# http://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
	local zero='%([BSUbfksu]|([FB]|){*})'
	local gitPromptSize=${#${(S%%)gitPrompt//$~zero/}}

	(( firstLineSize = $pwdsize + $gitPromptSize ))

	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))
	if [[ "$firstLineSize" -eq $TERMWIDTH ]]; then
		echo " "
	fi
}

function first_line() {
  local gitPrompt=$(git_prompt_info2)
  local line="%{$fg_bold[green]%}%m %{$fg[blue]%}%D{[%H:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} ${gitPrompt}%{$reset_color%}$(padding ${gitPrompt})"
  echo ${line}
}

# https://github.com/robbyrussell/oh-my-zsh/issues/3537
TRAPWINCH() {
  [[ -o zle ]] && zle reset-prompt; zle -R
}

NORMAL_MODE_INDICATOR="%{$fg[blue]%}-->%{$reset_color%}"
function vi_mode_prompt_info_egbomrt() {
  #echo "km:$KEYMAP"
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$NORMAL_MODE_INDICATOR}"
}

PROMPT=$'$(first_line)\
$(vi_mode_prompt_info_egbomrt)%(?.%{$fg[green]%}.%{$fg[red]%}) %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_NOCACHE="yes"
RPROMPT=""
