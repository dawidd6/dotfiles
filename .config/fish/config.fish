# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Brew
export HOMEBREW_BUNDLE_NO_DESCRIBE=1
export HOMEBREW_BUNDLE_NO_UPGRADE=1
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source

# PATH
fish_add_path --path --global --move --append ~/.local/bin

if status is-interactive
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
    function cdt
        set --local result (command tere $argv)
        [ -n "$result" ] && cd -- "$result"
    end
    function cdr
        set --local result (command git rev-parse --show-toplevel)
        [ -n "$result" ] && cd -- "$result"
    end
    function cdp
        set --local result (command wl-paste)
        [ -n "$result" ] && cd -- "$result"
    end

    # Completions
    complete -f -c git -n '__fish_git_using_command multi' -a '(set -l cmd (commandline -opc); set -e cmd[2]; complete -C (string join " " (string escape -- $cmd))" "(string escape -- (commandline -ct)))'

    # Binds
    bind ctrl-g edit_command_buffer
    bind ctrl-s 'fish_commandline_prepend sudo'

    # Exports
    export LANG='C.UTF-8'
    export PAGER='less'
    export EDITOR='nvim'
    export NVIM_LOG_FILE='/dev/null'

    # Abbrs
    abbr C wl-copy
    abbr P wl-paste
    abbr L 'less -RFXS'
    abbr D 'diff-so-fancy | less -RFX'
    abbr F 'fzf | wl-copy'
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
    abbr gb 'git branch -a'
    abbr gh 'git checkout'
    abbr ghm 'git checkout-main-branch'
    abbr gc 'git commit -m'
    abbr gca 'git commit --amend --no-edit'
    abbr gcae 'git commit --amend --edit'
    abbr gd 'git diff'
    abbr gdc 'git diff --cached'
    abbr gl 'git lg'
    abbr glp 'git log-preview'
    abbr gp 'git push'
    abbr gpf 'git push -f'
    abbr gpp 'git pull-preview'
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
    abbr bbc 'brew bundle -g check --verbose'
    abbr bbi 'brew bundle -g install'
    abbr t tmux

    # Aliases
    alias v nvim
    alias vi nvim
    alias vim nvim
    alias diffoscope 'diffoscope --text-color=always  --exclude-directory-metadata=recursive'
    alias fd 'fd --color=always --exclude=.git/ --no-ignore --hidden'
    alias rg 'rg --color=always --glob=!.git/ --heading --line-number --no-ignore --hidden --smart-case'
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
    fzf --fish | source
    starship init fish | source
    zoxide init fish --cmd=cd | source

    # Mux
    if not set -q TMUX && not set -q VSCODE_INJECTION
        tmux new-session -A
    end
end
