# dotfiles

1. Go to https://brew.sh and install Homebrew per instructions.
1. Run `brew install chezmoi`.
1. Run `chezmoi init --apply dawidd6`.
1. Run `brew bundle install --global`.
1. Run `echo "$HOMEBREW_PREFIX/bin/fish" | sudo tee --append /etc/shells`.
1. Run `sudo chsh --shell "$HOMEBREW_PREFIX/bin/fish" "$(whoami)"`.
1. Profit.
