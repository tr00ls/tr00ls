#!/bin/bash

cd ~/
echo "# So you want a cool terminal? Is it for the 1337 h4x?"
sleep 3
read -p "# Please enter target username: " target_user

# Check if git is installed, if not, install it.
if ! command -v git &> /dev/null
then
    sudo apt update && sudo apt install git -y
fi

# Check if zsh is installed, if not, install it.
if ! command -v zsh &> /dev/null
then
    sudo apt update && sudo apt install zsh -y
fi
chsh -s /usr/bin/zsh $target_user

# Install goodies
echo "# Want Fish-like Autosuggestions?"
sleep 3
echo "# Well.. You're getting it"
sleep 2

git clone https://github.com/zsh-users/zsh-autosuggestions /home/$target_user/.zsh/zsh-autosuggestions

echo "# Want Syntax highlighting?"
sleep 2
echo "# Guess what.. That too!"
sleep 2

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$target_user/.zsh/zsh-syntax-highlighting


echo "autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory
setopt autocd # change directory just by typing its name
#setopt correct # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch # hide error message if there is no match for the pattern
setopt notify # report the status of background jobs immediately
setopt numericglobsort # sort filenames numerically when it makes sense
setopt promptsubst # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

#hide EOL sign ('%')
PROMPT_EOL_MARK=""


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd' 


# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'
real\t%E
user\t%U
sys\t%S
cpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
debian_chroot=$(cat /etc/debian_chroot)
fi

# enable syntax-highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
. ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

else
PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
PROMPT_ALTERNATIVE=twoline
else
PROMPT_ALTERNATIVE=oneline
fi
configure_prompt
zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
;;
*)
;;
esac

precmd() {
# Print the previously configured title
print -Pnr -- "$TERM_TITLE"

# Print a new line before the prompt, but only if it is not the first line
if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
_NEW_LINE_BEFORE_PROMPT=1
else
print ""
fi
fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

export LESS_TERMCAP_mb=$'\E[1;31m' # begin blink
export LESS_TERMCAP_md=$'\E[1;36m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m' # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m' # begin underline
export LESS_TERMCAP_ue=$'\E[0m' # reset underline

# Take advantage of $LS_COLORS for completion as well
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# change suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
. /etc/zsh_command_not_found
fi
 " > /home/$target_user/.zshrc

echo "source /home/$target_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /home/$target_user/.zshrc
echo "source /home/$target_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /home/$target_user/.zshrc


echo "# You are much cooler now.." 
sleep 3
echo "# To finnish this, please type 'zsh' and press enter"
sleep 3
echo "Then log out or reboot to complete"
