# Colors
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Functions
function fish_greeting
end
function last_history_item
    echo $history[1]
end

# Completions
complete -f -c git -n '__fish_git_using_command multi' -a '(set -l cmd (commandline -opc); set -e cmd[2]; complete -C (string join " " (string escape -- $cmd))" "(string escape -- (commandline -ct)))'

# Binds
bind ctrl-g edit_command_buffer

# Exports
export LANG='C.UTF-8'
export EDITOR='nvim'
export PAGER='less'

# Abbrs
abbr !! --position anywhere --function last_history_item
abbr C wl-copy
abbr P wl-paste
abbr e exit
abbr d 'cd ~/.dotfiles'
abbr ef 'v ~/.config/fish/config.fish'
abbr eg 'v ~/.config/git/config'
abbr en 'v ~/.config/nvim/init.lua'
abbr et 'v ~/.config/tmux/tmux.conf'
abbr g git
abbr ga 'git add'
abbr gaa 'git add -A'
abbr gaf 'git add -f'
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
abbr gpp 'git preview-pull'
abbr gs 'git status -u'
abbr gt 'git tag'
abbr p podman
abbr pp 'podman ps'
abbr pi 'podman images'
abbr pr 'podman run --rm'
abbr pri 'podman run --rm -it'
abbr pe 'podman exec'
abbr pei 'podman exec -it'
abbr k kubectl
abbr ka 'kubectl apply -f'
abbr kd 'kubectl describe'
abbr ke 'kubectl exec -it'
abbr kg 'kubectl get'
abbr kgy 'kubectl get -o yaml'
abbr kr 'kubectl run -it --rm --restart=Never --image'
abbr kc kubectx
abbr kn kubens
abbr i incus
abbr ii 'incus info'
abbr ie 'incus exec -it $NAME -- sh'
abbr is 'incus shell'
abbr id 'incus delete'
abbr il 'incus list'
abbr ir 'incus launch --vm -c limits.cpu=4 -c limits.memory=4GiB -d root,size=50GiB $NAME images:'
abbr im 'incus config device add $NAME share disk source=$PWD path=$PWD'
abbr ic 'incus console --type vga'
abbr b brew
abbr bi 'brew install'
abbr br 'brew uninstall'
abbr bl 'brew list'
abbr bu 'brew upgrade'
abbr bbd 'brew bundle -g dump --force --formula --cask'

# Aliases
alias v nvim
alias vi nvim
alias vim nvim
alias eza 'eza --group-directories-first --group --header --time-style=long-iso'
alias l eza
alias ls eza
alias la 'eza -a'
alias ll 'eza -l'
alias lla 'eza -la'
alias lt 'eza --tree'
alias lta 'eza --tree -a'
alias tree 'eza --tree'
alias rm trash
alias ghub gh

# Sources
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
fzf --fish | source
starship init fish | source
zoxide init fish --cmd=cd | source

# PATH
fish_add_path --path --global --move --append ~/.local/bin "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
