# Ubuntu setup

## System tweaks

### Enable fingerprint authentication

1. Enroll fingerprints in settings.
1. Run `sudo pam-auth-update`.
2. Select the fingerprint checkbox.

### Font settings

1. Go to https://www.nerdfonts.com/font-downloads and download UbuntuMono.
2. Run `mkdir -p ~/.local/share/fonts`.
3. Run `unzip -o ~/Downloads/UbuntuMono.zip -d ~/.local/share/fonts`.
4. Run `fc-cache -v`.
5. Run `sudo apt install fonts-ubuntu-classic`.
6. Run `gsettings set org.gnome.desktop.interface font-name "Ubuntu 11"`.
7. Run `gsettings set org.gnome.desktop.interface monospace-font-name "UbuntuMono Nerd Font Regular 13"`.
8. Run `gsettings set org.gnome.desktop.wm.preferences titlebar-font "Ubuntu Bold 11"`.
8. Log out and log back in.

### Disable panel power savings

1. Add as root `amdgpu.abmlevel=0` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`.
2. Run `sudo update-grub`.

### GNOME keyring auto unlock with LUKS passphrase

1. Enable user auto-login in settings.
1. Run `sudo apt install keyutils`.
1. Append `,keyscript=decrypt_keyctl` to line in `/etc/crypttab`.
1. Append ` use_authtok` to `pam_gnome_keyring.so` line in `/etc/pam.d/common-password`.
1. Run `sudo update-initramfs -u -k all`.

### Swap software store app

1. Run `sudo snap --terminate --purge snap-store`.
2. Run `sudo apt install gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap`.

## Software installation

### Virt-manager

1. Run `sudo apt install virt-manager`.
2. Run `sudo usermod -aG kvm,libvirt $USER`.

### GNOME apps

1. Run `sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`.
2. TODO Run `flatpak install --user gnome-shell-extension-manager dconf-editor`

## Flox (Nix)

1. Go to https://flox.dev.
2. Download and install `.deb` package.
3. Change working directory to home and execute `flox init`.

## Google Chrome

1. Go to https://www.google.com/chrome.
2. Download and install `.deb` package.

## 1Password

1. Go to https://1password.com/downloads/linux.
2. Download and install `.deb` package.
3. Run `sudo apt update`.
4. Run `sudo apt install 1password-cli`.
5. Run `sudo ln -s /opt/1Password/op-ssh-sign /usr/local/bin/op-ssh-sign`.
6. Open the app and set it up.

## VSCode

1. Go to https://code.visualstudio.com/download.
2. Download and install `.deb` package.
3. Open the app and sync settings.

## Incus

1. Go to https://github.com/zabbly/incus.
2. Follow instructions there.
3. Run `sudo adduser $USER incus`.
