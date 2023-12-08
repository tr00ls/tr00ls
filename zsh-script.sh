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
eval \"\$(dircolors -b)\"
zstyle ':completion:*:default' list-colors \${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u \$USER -o pid,%cpu,tty,cputime,cmd' " > /home/$target_user/.zshrc

echo "source /home/$target_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /home/$target_user/.zshrc
echo "source /home/$target_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /home/$target_user/.zshrc


echo "# You are much cooler now.." 
sleep 3
echo "# To finnish this, please type 'zsh' and press enter"
sleep 5
echo "Then log out or reboot to complete"
