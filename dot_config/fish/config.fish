# Exports
export EDITOR='nvim'
export PAGER='less'
export HOMEBREW_NO_INSTALL_FROM_API='1'
export HOMEBREW_EDITOR="env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR WAYLAND_DISPLAY=$WAYLAND_DISPLAY $EDITOR"
export FZF_DEFAULT_OPTS="--bind pgup:preview-up,pgdn:preview-down"

# Sources
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source

# PATH
fish_add_path --path --global --move --append ~/.local/share/chezmoi/bin ~/.local/bin "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

if status --is-interactive
    # Sources
    fzf --fish | source
    starship init fish | source
    zoxide init fish --cmd=cd | source

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
    function __auto_ls --on-variable PWD
        ls
    end

    # Exports
    export LANG='C.UTF-8'

    # Abbrs
    abbr !! --position anywhere --function last_history_item
    abbr pbcopy 'wl-copy'
    abbr pbpaste 'wl-paste'
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
    abbr k 'kubectl'
    abbr ka 'kubectl apply -f'
    abbr kd 'kubectl describe'
    abbr kg 'kubectl get'
    abbr kgy 'kubectl get -o yaml'
    abbr kc 'kubectx'
    abbr kn 'kubens'
    abbr ch 'chezmoi'
    abbr cha 'chezmoi apply'
    abbr chc 'chezmoi cd'
    abbr chd 'chezmoi diff'
    abbr che 'chezmoi edit'
    abbr chea 'chezmoi edit --apply'
    abbr chs 'chezmoi status'
    abbr ef 'vi ~/.config/fish/config.fish'
    abbr en 'vi ~/.config/nvim/init.lua'
    abbr eg 'vi ~/.config/git/config'

    # Aliases
    alias v 'nvim'
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
    alias ghub 'gh'
end
