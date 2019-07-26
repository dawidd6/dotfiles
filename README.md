### Init

```sh
git init --bare $HOME/.dotfiles
alias dotfiles "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
```

### Clone

```sh
git clone --bare git@github.com:dawidd6/dotfiles.git $HOME/.dotfiles
alias dotfiles "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```