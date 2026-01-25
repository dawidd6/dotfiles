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
    abbr lxc-vm 'lxc launch --vm -c limits.cpu=4 -c limits.memory=4GiB -d root,size=50GiB'
    abbr lxc-mount 'lxc config device add $VM_NAME share disk source=$PWD path=$PWD'
    abbr lxc-display 'lxc console --type vga'

    # Aliases
    alias vi 'nvim'
    alias vim 'nvim'
    alias eza 'eza --group-directories-first --group --header --time-style=long-iso'
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls 'eza'
    alias l 'eza'
    alias lt 'eza --tree'
    alias tree 'eza --tree'
    alias rm 'trash'
    alias ssh 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    alias hub 'gh'

    # Sources
    fzf --fish | source
    starship init fish | source
    zoxide init fish --cmd=cd | source
end
