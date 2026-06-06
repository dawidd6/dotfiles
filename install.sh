#!/usr/bin/env bash

set -euo pipefail

dotfiles_user=dawidd6

brew_packages=(
    age
    chezmoi
    diff-so-fancy
    diffoscope
    dos2unix
    eza
    fd
    fish
    fzf
    fx
    git
    glow
    helm
    htop
    ipcalc
    k9s
    kubectl
    kustomize
    make
    neovim
    ripgrep
    sops
    starship
    trash-cli
    wl-clipboard
    zoxide
)

apt_packages=(
    podman
)

function check() {
    if test $EUID -eq 0 && ! test -e /run/.containerenv; then
        echo "Do not run this as root!"
        exit 127
    fi
}

function setup_apt() {
    if ! dpkg -l "${apt_packages[@]}" &>/dev/null; then
        sudo apt install -y "${apt_packages[@]}"
    fi
}

function setup_brew() {
    if ! test -e /home/linuxbrew/.linuxbrew/bin/brew; then
        if ! dpkg -l build-essential curl file git procps &>/dev/null; then
            sudo apt install -y build-essential curl file git procps
        fi
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
    brew install "${brew_packages[@]}" 2>/dev/null
    if ! grep -q /home/linuxbrew/.linuxbrew/bin/fish /etc/shells; then
        echo /home/linuxbrew/.linuxbrew/bin/fish | sudo tee -a /etc/shells
        sudo chsh -s /home/linuxbrew/.linuxbrew/bin/fish "$(whoami)"
    fi
}

function setup_dotfiles() {
    if ! chezmoi git rev-parse &>/dev/null; then
        chezmoi init --apply "$dotfiles_user"
    fi
}

function setup_desktop() {
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

        if ! grep -q fprintd /etc/pam.d/common-auth; then
            sudo pam-auth-update --enable fprintd
        fi

        if ! dpkg -l fonts-ubuntu-classic &>/dev/null; then
            sudo apt purge -y fonts-noto-core
            sudo apt install -y fonts-ubuntu-classic
        fi

        if ! command -v flatpak &>/dev/null; then
            sudo apt install -y flatpak
            sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        fi
    fi
}

check
setup_apt
setup_brew
setup_dotfiles
setup_desktop
