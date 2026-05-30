#!/usr/bin/env bash

set -euo pipefail

if [ $EUID -eq 0 ]; then
    echo "Do not run this as root!"
    exit 127
fi

sudo apt autopurge -y diffoscope-minimal dos2unix eza fd-find fish fzf git-delta htop lm-sensors make neovim picocom ripgrep starship trash-cli zoxide

# APT
sudo apt install -y podman wl-clipboard

# Homebrew
sudo apt install -y build-essential curl file git procps

if ! [ -e /home/linuxbrew/.linuxbrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

brew install diff-so-fancy diffoscope dos2unix eza fd fish fzf htop make neovim ripgrep starship trash-cli zoxide

if ! grep -q /home/linuxbrew/.linuxbrew/bin/brew /etc/shells; then
    echo /home/linuxbrew/.linuxbrew/bin/fish | sudo tee -a /etc/shells
    sudo chsh -s /home/linuxbrew/.linuxbrew/bin/fish "$USER"
fi

# Desktop
if command -v gnome-shell &>/dev/null; then
    if ! test -d ~/.local/share/fonts; then
        cd /tmp
        mkdir -p ~/.local/share/fonts
        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip
        unzip -o UbuntuMono.zip -d ~/.local/share/fonts
    fi

    gnome-extensions disable ubuntu-dock@ubuntu.com
    gnome-extensions disable ding@rastersoft.com

    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'UbuntuMono Nerd Font 13'
    gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 11'
    gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
    gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 100

    sudo pam-auth-update --enable fprintd

    sudo apt purge fonts-noto-core
    sudo apt install fonts-ubuntu-classic

    sudo apt install -y flatpak
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi
