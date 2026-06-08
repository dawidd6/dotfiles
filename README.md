# dotfiles

1. Install [Homebrew](https://brew.sh).
1. Run commands:

    ```sh
    brew install chezmoi
    chezmoi init --apply dawidd6
    brew bundle install --global
    echo "$HOMEBREW_PREFIX/bin/fish" | sudo tee --append /etc/shells
    sudo chsh --shell "$HOMEBREW_PREFIX/bin/fish" "$(whoami)"
    ```
1. Profit.
