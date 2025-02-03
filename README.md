# Workstation setup

This is for Ubuntu Desktop specifically.

### Enable fingerprint authentication

1. Enroll fingerprints in settings.
1. Run `sudo pam-auth-update`.
2. Select the fingerprint checkbox.

### Disable AMD panel power savings

1. Add as root `amdgpu.abmlevel=0` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`.
2. Run `sudo update-grub`.

### Set up fonts

1. Go to https://www.nerdfonts.com/font-downloads and download UbuntuMono.
2. Run `mkdir -p ~/.local/share/fonts`.
3. Run `unzip -o ~/Downloads/UbuntuMono.zip -d ~/.local/share/fonts`.
4. Run `fc-cache -fv`.
5. Run `sudo apt install fonts-ubuntu-classic`.
6. Run `gsettings set org.gnome.desktop.interface font-name "Ubuntu 11"`.
7. Run `gsettings set org.gnome.desktop.interface monospace-font-name "UbuntuMono Nerd Font Regular 13"`.
8. Run `gsettings set org.gnome.desktop.wm.preferences titlebar-font "Ubuntu Bold 11"`.
8. Log out and log back in.

### Set auto unlock of GNOME keyring with LUKS passphrse

1. Enable user auto-login in settings.
1. Run `sudo apt install keyutils`.
1. Append `,keyscript=decrypt_keyctl` to line in `/etc/crypttab`.
1. Append ` use_authtok` to `pam_gnome_keyring.so` line in `/etc/pam.d/common-password`.
1. Run `sudo update-initramfs -u -k all`.

### Swap software store apps

1. Run `sudo snap remove --terminate --purge snap-store`.
2. Run `sudo apt install gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap`.

### Install various desktop apps

1. Run `sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`.
2. Open GNOME software app.
3. Install below apps via flatpak:
- TODO

### Install virt-manager

1. Run `sudo apt install virt-manager`.
2. Run `sudo usermod -aG kvm,libvirt $USER`.

### Install Google Chrome

1. Go to https://www.google.com/chrome.
2. Download and install `.deb` package.

### Install 1Password

1. Go to https://1password.com/downloads/linux.
2. Download and install `.deb` package.
3. Run `sudo apt update`.
4. Run `sudo apt install 1password-cli`.
5. Run `sudo ln -s /opt/1Password/op-ssh-sign /usr/local/bin/op-ssh-sign`.
6. Open Ignition app.
7. Add 1Password to the autostart list.
8. Modify Exec line to include `--silent` flag.

### Install VSCode

1. Go to https://code.visualstudio.com/download.
2. Download and install `.deb` package.
3. Open the app and sync settings.

### Install incus

1. Go to https://github.com/zabbly/incus.
2. Follow instructions there.
3. Run `sudo adduser $USER incus`.

### Install flox (Nix)

1. Go to https://flox.dev.
2. Download and install `.deb` package.

### Set up dotfiles

1. Run `git clone https://github.com/dawidd6/dotfiles ~/.dotfiles`.
2. Run `cd ~/.dotfiles`.
3. Run `flox activate`.
4. Run `stow .`.
