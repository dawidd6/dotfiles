# Ubuntu setup

## Enable fingerprint authentication

1. Enroll fingerprints in settings.
1. Run `sudo pam-auth-update`.
2. Select the fingerprint checkbox.

## Disable panel power savings

1. Add as root `amdgpu.abmlevel=0` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`.
2. Run `sudo update-grub`.

## GNOME keyring auto unlock with LUKS passphrase

1. Enable user auto-login in settings.
1. Run `sudo apt install keyutils`.
1. Append `,keyscript=decrypt_keyctl` to line in `/etc/crypttab`.
1. Append ` use_authtok` to `pam_gnome_keyring.so` line in `/etc/pam.d/common-password`.
1. Run `sudo update-initramfs -u -k all`.

## Font revert to classic variant

1. Run `sudo apt install fonts-ubuntu-classic`.
2. TODO gsettings
3. Log out and log back in.

## Third-party software from websites

### Flox (Nix)

1. Go to https://flox.dev.
2. Download and install `.deb` package.

### Google Chrome

1. Go to https://www.google.com/chrome.
2. Download and install `.deb` package.

### 1Password

Go to TODO.

### VSCode

Go to TODO.

### Incus

1. Go to https://github.com/zabbly/incus.
2. Follow instructions there.
