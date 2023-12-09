#!/bin/bash

cd ~/
echo "# So you want a cool terminal? Is it for the 1337 h4x?"
sleep 1
read -p "# Please enter target username: " target_user
sleep 1

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
sleep 2
echo "# Well.. You're getting it"
sleep 2

git clone https://github.com/zsh-users/zsh-autosuggestions /home/$target_user/.zsh/zsh-autosuggestions

echo "# Want Syntax highlighting?"
sleep 2
echo "# Guess what.. You're getting that too!"
sleep 1

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$target_user/.zsh/zsh-syntax-highlighting

# Configuring new .zshrc
mv /home/$target_user/.zshrc /home/$target_user/.zshrc.bak

wget -q -O /home/$target_user/.zshrc https://raw.githubusercontent.com/tr00ls/tr00ls/main/.zshrc


echo "source /home/$target_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /home/$target_user/.zshrc
echo "source /home/$target_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /home/$target_user/.zshrc

echo "# You are much cooler now.." 
sleep 3
echo "# To finish this, please type 'zsh' and press enter"
sleep 2
echo "Then log out or reboot to complete"
sleep 2
