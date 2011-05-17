#zsh history stuff
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=2000
setopt appendhistory
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY SHARE_HISTORY

setopt autolist
unsetopt menucomplete

autoload -U compinit
compinit


export EDITOR="vim"

alias e=$EDITOR


typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
coreprompt="%n@%m"
baseprompt="$coreprompt:%~ "

case $TERM in
   xterm|xterm-color|color_xterm|xterm-256color|screen-256color|screen|rxvt-unicode)
	PROMPT="%{]0;$baseprompt%}$baseprompt"
	PROMPT="$PROMPT"
	RPROMPT=$'$(vcs_info_wrapper)'

	preexec () {
		print -nP '\033]0;'
		print -nP "$coreprompt: "
		print -nPR "%60>...>${(V)1//\%/%%}"
		print -n '\007'
		if [ "$TERM" = screen ]; then
			print -nP '\033k%'
			print -nPR "%60>...>${(V)1//\%/%%}"
			print -n '\033\\'
		fi
	}
	if [ "$TERM" = screen ]; then
		PROMPT="%{kzsh\\%}$PROMPT"
	fi

  ;;
  *) PROMPT="$baseprompt "
  ;;
esac
unset baseprompt
[[ UID -eq 0 ]] && PROMPT=${PROMPT/\}%n/\}%U%n%u}

bindkey -e

alias ls='ls --color=auto'
alias g='ack'

#git aliases
alias gb='git branch'
alias gca='git commit -a'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status -s -uno'
alias gsa='git status'
alias gcl='git log --no-merges --pretty=format:" - %s (%an)"'

