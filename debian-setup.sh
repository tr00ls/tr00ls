#!/bin/bash

# --------------------------------------------------
# Intended to run as root.
# Sets up a 'fresh' Debian install/container to my liking
# --------------------------------------------------

new_user=""
user_zsh=""
zsh_changes=false

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Make sure we're running as root
if [ "$EUID" -ne 0 ]; then
    echo
    echo "Please run this script as root."
    sleep 1
    exit 1
fi

echo
echo "Starting system update and installing some packages"
echo
sleep 1

# Update the system
if ! apt update; then
    echo
    echo "apt update failed. Exiting."
    sleep 1
    exit 1
fi

if ! apt dist-upgrade -y; then
    echo
    echo "apt dist-upgrade failed. Exiting."
    sleep 1
    exit 1
fi

if ! apt autoremove -y; then
    echo
    echo "apt autoremove failed. Exiting."
    sleep 1
    exit 1
fi

# Install packages
if ! apt install wget net-tools sudo ncdu btop git zsh -y; then
    echo
    echo "Package installation failed. Exiting."
    sleep 1
    exit 1
fi

# --------------------------------------------------
# Zsh with goodies for root? Y/n
# --------------------------------------------------
echo
read -rp "Want zsh with goodies for root account? [Y/n]: " root_zsh

root_zsh=${root_zsh:-Y}

if [[ "$root_zsh" =~ ^[Yy]$ ]]; then
    echo
    echo "Setting up zsh with goodies for root..."
    sleep 1

    chsh -s /usr/bin/zsh root

    mkdir -p /root/.zsh

    # zsh-autosuggestions
    if [ -d "/root/.zsh/zsh-autosuggestions" ]; then
        echo
        echo "zsh-autosuggestions already installed for root. Skipping."
    else
        if ! git clone https://github.com/zsh-users/zsh-autosuggestions \
            /root/.zsh/zsh-autosuggestions; then
            echo
            echo "Failed to install zsh-autosuggestions for root."
            exit 1
        fi
    fi

    # Add autosuggestions to .zshrc if not already present
    if ! grep -qxF "source /root/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" /root/.zshrc 2>/dev/null; then
        echo "source /root/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" \
            >> /root/.zshrc
    fi

    # zsh-syntax-highlighting
    if [ -d "/root/.zsh/zsh-syntax-highlighting" ]; then
        echo "zsh-syntax-highlighting already installed for root. Skipping."
    else
        if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            /root/.zsh/zsh-syntax-highlighting; then
            echo
            echo "Failed to install zsh-syntax-highlighting for root."
            sleep 1
            exit 1
        fi
    fi

    # Add syntax highlighting to .zshrc if not already present
    if ! grep -qxF "source /root/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" /root/.zshrc 2>/dev/null; then
        echo "source /root/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
            >> /root/.zshrc
    fi

    zsh_changes=true


elif [[ "$root_zsh" =~ ^[Nn]$ ]]; then
    echo
    echo "Skipping zsh install for root account."

else
    echo
    echo "Invalid choice. Please enter Y or N, or just press Enter for Y."
    sleep 1
    exit 1

fi

sleep 1

# --------------------------------------------------
# Create sudo user? Y/n
# --------------------------------------------------
echo
read -rp "Want to add a sudo user? [Y/n]: " create_user

create_user=${create_user:-Y}

if [[ "$create_user" =~ ^[Yy]$ ]]; then

    # Ask for username
    read -rp "Enter username: " new_user

    if [ -z "$new_user" ]; then
        echo
        echo "No username entered. Exiting."
        sleep 1
        exit 1
    fi

    # Create user
    if id "$new_user" &>/dev/null; then
        echo
        echo "User $new_user already exists. Skipping user creation."
        sleep 1
    else
        if ! adduser "$new_user"; then
            echo
            echo "Failed to create user $new_user."
            sleep 1
            exit 1
        fi
    fi

    # Make sure the user is in the sudo group
    usermod -aG sudo "$new_user"

    echo
    echo "User $new_user has sudo access."

    sleep 1

    # --------------------------------------------------
    # Zsh with goodies for new user? Y/n
    # --------------------------------------------------
    echo
    read -rp "Want zsh with goodies for $new_user? [Y/n]: " user_zsh

    user_zsh=${user_zsh:-Y}

    if [[ "$user_zsh" =~ ^[Yy]$ ]]; then

        echo
        echo "Setting up zsh for $new_user..."
        sleep 1

        chsh -s /usr/bin/zsh "$new_user"

        mkdir -p "/home/$new_user/.zsh"

        # zsh-autosuggestions
        if [ -d "/home/$new_user/.zsh/zsh-autosuggestions" ]; then
            echo
            echo "zsh-autosuggestions already installed for $new_user. Skipping."
        else
            if ! git clone https://github.com/zsh-users/zsh-autosuggestions \
                "/home/$new_user/.zsh/zsh-autosuggestions"; then
                echo
                echo "Failed to install zsh-autosuggestions for $new_user."
                sleep 1
                exit 1
            fi
        fi

        # Add autosuggestions to .zshrc if not already present
        if ! grep -qxF "source /home/$new_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" "/home/$new_user/.zshrc" 2>/dev/null; then
            echo "source /home/$new_user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" \
                >> "/home/$new_user/.zshrc"
        fi

        # zsh-syntax-highlighting
        if [ -d "/home/$new_user/.zsh/zsh-syntax-highlighting" ]; then
            echo
            echo "zsh-syntax-highlighting already installed for $new_user. Skipping."
        else
            if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
                "/home/$new_user/.zsh/zsh-syntax-highlighting"; then
                echo
                echo "Failed to install zsh-syntax-highlighting for $new_user."
                sleep 1
                exit 1
            fi
        fi

        # Add syntax highlighting to .zshrc if not already present
        if ! grep -qxF "source /home/$new_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "/home/$new_user/.zshrc" 2>/dev/null; then
            echo "source /home/$new_user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
                >> "/home/$new_user/.zshrc"
        fi

        chown -R "$new_user:$new_user" "/home/$new_user/.zsh"
        chown "$new_user:$new_user" "/home/$new_user/.zshrc"

        zsh_changes=true


    elif [[ "$user_zsh" =~ ^[Nn]$ ]]; then

        echo
        echo "Skipping zsh install for $new_user."

    else

        echo
        echo "Invalid choice. Please enter Y or N, or just press Enter for Y."
        sleep 1
        exit 1

    fi


elif [[ "$create_user" =~ ^[Nn]$ ]]; then

    echo
    echo "Skipping sudo user creation."

else

    echo
    echo "Invalid choice. Please enter Y or N, or just press Enter for Y."
    sleep 1
    exit 1

fi

# --------------------------------------------------
# Finished
# --------------------------------------------------
sleep 2
echo
echo "======================================"
echo " Debian setup complete!"
echo "======================================"
echo

# Sudo user
if [ -n "$new_user" ]; then
    echo "New sudo user: $new_user"
else
    echo "New sudo user: No"
fi

# Root zsh
if [[ "$root_zsh" =~ ^[Yy]$ ]]; then
    echo "Zsh for root account: Yes"
else
    echo "Zsh for root account: No"
fi

# New user's zsh
if [ -n "$new_user" ]; then

    if [[ "$user_zsh" =~ ^[Yy]$ ]]; then
        echo "Zsh for $new_user: Yes"
    else
        echo "Zsh for $new_user: No"
    fi

else
    echo "Zsh for new user: Not applicable"
fi

if [ "$zsh_changes" = true ]; then
    echo
    echo "Logout, reboot or reopen this session for zsh changes to take effect."
else
    echo
    echo "No zsh changes were made. No logout or reboot is required."
fi