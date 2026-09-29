#!/bin/bash

# --------------------------------------------------
# Setup zsh with goodies (autosuggestions and syntax highlighting) for target sudo user.
# --------------------------------------------------

cd ~/
read -p "# Please enter target username: " target_user

# Check if git is installed, if not, install it.
if ! command -v git &> /dev/null
then
    sudo apt update && sudo apt install git -y
fi

# Check if zsh is installed, if not, install it.
echo "Installing zsh"
sleep 1
if ! command -v zsh &> /dev/null
then
    sudo apt update && sudo apt install zsh -y
fi
chsh -s /usr/bin/zsh $target_user

mkdir -p "/home/$target_user/.zsh"

# Install goodies
echo "Installing Fish-like Autosuggestions?"
sleep 1

git clone https://github.com/zsh-users/zsh-autosuggestions /home/$target_user/.zsh/zsh-autosuggestions
echo "source /home/$target_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /home/$target_user/.zshrc

echo "Installing syntax highlighting?"
sleep 1

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$target_user/.zsh/zsh-syntax-highlighting
echo "source /home/$target_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /home/$target_user/.zshrc
sleep 2

echo "Logout, reboot or reopen this session for zsh changes to take effect."
