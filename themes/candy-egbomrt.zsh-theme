source ~/.zsh/git-prompt/zshrc.sh

# This function is a workaround to a strange zsh bug with multi-line
# prompts and vi-mode (zle reset-prompt)
function padding() {
	local pwdsize=${#${(%):-%m %D{[%H:%M:%S]} [%~]}}

	# http://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
	gitPrompt=$(git_prompt_info2)
	local zero='%([BSUbfksu]|([FB]|){*})'
	gitPromptSize=${#${(S%%)gitPrompt//$~zero/}}

	(( firstLineSize = $pwdsize + $gitPromptSize ))

	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))
	if [[ "$firstLineSize" -eq $TERMWIDTH ]]; then
		echo " "
	fi
}

PROMPT=$'%{$fg_bold[green]%}%m %{$fg[blue]%}%D{[%H:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info2)%{$reset_color%}$(padding)\
$(vi_mode_prompt_info)%{$fg[blue]%}->%(?.%{$fg[green]%}.%{$fg[red]%}) %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_NOCACHE="yes"
RPROMPT=""
