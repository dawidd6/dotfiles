# Exports
status is-interactive && export LANG='C.UTF-8'
export PAGER='less'
export EDITOR='nvim'
export FZF_DEFAULT_OPTS='--reverse'
export NVIM_LOG_FILE='/dev/null'
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export HOMEBREW_BUNDLE_NO_DESCRIBE=1
export HOMEBREW_BUNDLE_NO_UPGRADE=1
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1

# Sources
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
fzf --fish | source
starship init fish | source
zoxide init fish --cmd cd | source

# PATH
fish_add_path --path --global --move "$HOME/.local/bin"

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
function cdt --description 'Tere based cd command'
    set --local result (command tere $argv)
    test -n "$result" && cd -- "$result"
end
function cdr --description 'Git root based cd command'
    set --local result (command git rev-parse --show-toplevel)
    test -n "$result" && cd -- "$result"
end
function cdp --description 'Clipboard based cd command'
    set --local result (command wl-paste)
    test -n "$result" && cd -- "$result"
end
function git --wraps git
    if test "$PWD" = "$HOME/.dotfiles"
        GIT_DIR="$PWD" command git -C "$HOME" $argv
    else
        command git $argv
    end
end

# Completions
complete -c git-multi -w git
complete -c git-log-preview -w 'git log'

# Binds
bind ctrl-g edit_command_buffer
bind ctrl-s 'fish_commandline_prepend sudo'
bind \e\[1\;5C nextd-or-forward-word
bind \e\[1\;5D prevd-or-backward-word

# Abbrs
abbr C wl-copy
abbr P wl-paste
abbr D 'diff-so-fancy | less --tabs 4 -RFX'
abbr R 'exec fish'
abbr r reset
abbr e exit
abbr d 'cd ~/.dotfiles'
abbr ef 'nvim ~/.config/fish/config.fish'
abbr eg 'nvim ~/.config/git/config'
abbr en 'nvim --cmd "cd ~/.config/nvim"'
abbr et 'nvim ~/.config/tmux/tmux.conf'
abbr es 'nvim --cmd "cd ~/.local/bin"'
abbr g git
abbr ga 'git add'
abbr gaa 'git add -A'
abbr gaf 'git add -f'
abbr gap 'git add -p'
abbr gb 'git branch -a'
abbr gh 'git checkout'
abbr ghb 'git checkout -b'
abbr ghm 'git checkout-main-branch'
abbr ghp 'git checkout -p'
abbr gc 'git commit -m'
abbr gca 'git commit --amend --no-edit'
abbr gcae 'git commit --amend --edit'
abbr gd 'git diff'
abbr gdc 'git diff --cached'
abbr gdn 'git diff --no-index'
abbr gg 'git grep'
abbr gl 'git lg'
abbr glp 'git log-preview'
abbr gp 'git push'
abbr gpf 'git push -f'
abbr gpd 'git push --delete'
abbr gpp 'git pull-preview'
abbr gs 'git status -u'
abbr gt 'git tag'
abbr gu 'git unadd'
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
abbr bbc 'brew bundle -g check --verbose'
abbr bbi 'brew bundle -g install'
abbr t tmux
abbr l ls
abbr v nvim
abbr vi nvim
abbr vim nvim

# Aliases
alias rm 'command trash'
alias ghub 'command gh'
alias fd 'fd --exclude .git --no-ignore --hidden'
alias rg 'rg --glob "!**/.git/**" --no-ignore --hidden --smart-case'
alias ls 'eza --group-directories-first --group --header --time-style long-iso --all'
alias ll 'ls --long --icons'
alias lt 'll --tree --level 2 --ignore-glob .git'

# Mux
if status is-interactive && not set -q TMUX && not set -q VSCODE_INJECTION
    tmux new-session -A -s main
end
