# dotfiles

1. Install [Homebrew](https://brew.sh).

1. Initialize dotfiles:

    ```sh
    git -c remote.origin.fetch='+refs/heads/*:refs/remotes/origin/*' --bare clone https://github.com/dawidd6/dotfiles ~/.dotfiles
    git --git-dir ~/.dotfiles --work-tree ~ checkout
    ```

1. Install things:

    ```sh
    brew bundle install --global
    ```

1. Set shell:

    ```sh
    echo /home/linuxbrew/.linuxbrew/bin/fish | sudo tee --append /etc/shells
    sudo chsh --shell /home/linuxbrew/.linuxbrew/bin/fish "$(whoami)"
    ```

1. Profit.
