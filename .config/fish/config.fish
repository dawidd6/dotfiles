# Colors
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Functions
function fish_greeting; end
function last_history_item
    echo $history[1]
end

# Exports
export LANG='C.UTF-8'
export EDITOR='nvim'
export PAGER='less'

# Abbrs
abbr !! --position anywhere --function last_history_item
abbr C 'wl-copy'
abbr P 'wl-copy'
abbr e 'exit'
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch -a'
abbr gh 'git checkout'
abbr ghm 'git checkout-main-branch'
abbr gc 'git commit -m'
abbr gca 'git commit --amend --no-edit'
abbr gcae 'git commit --amend --edit'
abbr gd 'git diff'
abbr gdc 'git diff --cached'
abbr gl 'git lg'
abbr gp 'git push'
abbr gpf 'git push -f'
abbr gs 'git status -u'
abbr gt 'git tag'
abbr p 'podman'
abbr pp 'podman ps'
abbr pi 'podman images'
abbr pr 'podman run --rm'
abbr pri 'podman run --rm -it'
abbr pe 'podman exec'
abbr pei 'podman exec -it'
abbr k 'kubectl'
abbr ka 'kubectl apply -f'
abbr kd 'kubectl describe'
abbr ke 'kubectl exec -it'
abbr kg 'kubectl get'
abbr kgy 'kubectl get -o yaml'
abbr kr 'kubectl run -it --rm --restart=Never --image'
abbr kc 'kubectx'
abbr kn 'kubens'
abbr ef 'vi ~/.config/fish/config.fish'
abbr en 'vi ~/.config/nvim/init.lua'
abbr eg 'vi ~/.config/git/config'
abbr d 'dotfiles'
abbr da 'dotfiles add -f'
abbr dh 'dotfiles checkout'
abbr dc 'dotfiles commit -m'
abbr dca 'dotfiles commit --amend --no-edit'
abbr dcae 'dotfiles commit --amend --edit'
abbr dd 'dotfiles diff'
abbr ddc 'dotfiles diff --cached'
abbr dl 'dotfiles lg'
abbr dls 'dotfiles ls'
abbr dp 'dotfiles push'
abbr ds 'dotfiles status -u'
abbr i 'incus'
abbr ii 'incus info'
abbr ie 'incus exec -it $NAME -- sh'
abbr is 'incus shell'
abbr id 'incus delete'
abbr il 'incus list'
abbr ir 'incus launch --vm -c limits.cpu=4 -c limits.memory=4GiB -d root,size=50GiB $NAME images:'
abbr im 'incus config device add $NAME share disk source=$PWD path=$PWD'
abbr ic 'incus console --type vga'

# Aliases
alias v 'nvim'
alias vi 'nvim'
alias vim 'nvim'
alias eza 'eza --group-directories-first --group --header --time-style=long-iso'
alias l 'eza'
alias ls 'eza'
alias la 'eza -a'
alias ll 'eza -l'
alias lla 'eza -la'
alias lt 'eza --tree'
alias tree 'eza --tree'
alias rm 'trash'
alias ssh 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias ghub 'gh'
alias dotfiles 'git --git-dir "$HOME/.dotfiles" --work-tree "$HOME"'

# Sources
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
fzf --fish | source
starship init fish | source
zoxide init fish --cmd=cd | source

# PATH
fish_add_path --path --global --move --append ~/.local/bin "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
