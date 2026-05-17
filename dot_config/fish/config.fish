if status is-interactive
    # Scripts
    fish_add_path --path --global --move ~/.local/share/chezmoi/bin

    # Colors
    set fish_color_command green
    set fish_color_param normal
    set fish_color_error red --bold
    set fish_color_normal normal
    set fish_color_comment brblack
    set fish_color_quote yellow

    # Exports
    export EDITOR='nvim'
    export PAGER='less'
    export SHELL='fish'

    # Abbreviations
    if command -q wl-copy
        abbr clip 'wl-copy'
    else if command -q xsel
        abbr clip 'xsel --clipboard'
    end
    abbr e 'exit'
    abbr g 'git'
    abbr ga 'git add'
    abbr gb 'git branch -a'
    abbr gc 'git commit -m'
    abbr gca 'git commit --amend --no-edit'
    abbr gcae 'git commit --amend --edit'
    abbr gd 'git diff'
    abbr gdc 'git diff --cached'
    abbr gh 'git checkout'
    abbr ghm 'git checkout-main-branch'
    abbr gp 'git push'
    abbr gpf 'git push -f'
    abbr gs 'git status -u'
    abbr gt 'git tag'
    abbr p 'podman'
    abbr k 'kubectl'
    abbr lxc-vm 'lxc launch --vm -c limits.cpu=4 -c limits.memory=4GiB -d root,size=50GiB'
    abbr lxc-mount 'lxc config device add $VM_NAME share disk source=$PWD path=$PWD'
    abbr lxc-display 'lxc console --type vga'

    # Aliases
    alias vi 'command nvim'
    alias vim 'command nvim'
    alias eza 'command eza --group-directories-first --group --header --time-style=long-iso'
    alias la 'command eza -a'
    alias ll 'command eza -l'
    alias lla 'command eza -la'
    alias ls 'command eza'
    alias l 'command eza'
    alias lt 'command eza --tree'
    alias tree 'command eza --tree'
    alias rm 'command trash'
    alias ssh 'command ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    alias ghub 'command gh'
    alias bat 'command batcat'

    # Inits
    fzf --fish | source
    starship init fish | source
    zoxide init fish --cmd=cd | source

    # Completions
    chezmoi completion fish | source
    helm completion fish | source
    kubectl completion fish | source
end
