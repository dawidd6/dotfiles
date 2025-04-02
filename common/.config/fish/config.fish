if status is-interactive
    # Flox
    function flox-gen-man-cache
        if test "$FLOX_ENV_DESCRIPTION" = "default"
            echo 'Generating flox man cache...'
            mandb -C (echo "MANDB_MAP $FLOX_ENV/share/man $HOME/.cache/flox/man" | psub) --user-db --quiet --create --no-straycats
        end
    end
    function flox --wraps=flox
        command flox $argv
        if contains -- $argv[1] install uninstall
            flox-gen-man-cache
        end
    end
    set -p fish_complete_path "$FLOX_ENV/share/fish/vendor_completions.d"
    set -gx MANPATH ~/.cache/flox/man:
    if not test -d ~/.cache/flox/man
        flox-gen-man-cache
    end

    # Scripts
    fish_add_path --path --global --move ~/.bin

    # Colors
    set fish_color_command green
    set fish_color_param normal
    set fish_color_error red --bold
    set fish_color_normal normal
    set fish_color_comment brblack
    set fish_color_quote yellow

    # Exports
    export EDITOR=nvim
    export PAGER=less
    export SHELL=fish

    # Abbreviations
    abbr clip 'xsel --clipboard'
    abbr e 'exit'
    abbr g 'git'
    abbr ga 'git add'
    abbr gb 'git branch -a'
    abbr gc 'git commit -m'
    abbr gca 'git commit --amend --no-edit'
    abbr gcae 'git commit --amend --edit'
    abbr gd 'git diff'
    abbr gdc 'git diff --cached'
    abbr gf 'git fetch'
    abbr gfo 'git fetch origin'
    abbr gh 'git checkout'
    abbr ghm 'git checkout-main-branch'
    abbr gp 'git push'
    abbr gpo 'git push origin -u'
    abbr gs 'git status -u'
    abbr gt 'git tag'
    abbr p 'podman'
    abbr incus-vm 'incus launch --vm -c limits.cpu=4 -c limits.memory=4GiB -d root,size=50GiB'
    abbr incus-mount 'incus config device add $VM_NAME share disk source=$HOME/test path=$HOME/share'
    abbr incus-display 'incus console --type vga'
    abbr fishedit 'vi ~/.config/fish/config.fish'
    abbr nvimedit 'vi ~/.config/nvim/init.lua'

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

    # Functions
    function hub --wraps=gh
        if command -q op
            command op plugin run -- gh $argv
        else
            command gh $argv
        end
    end

    # Sources
    carapace nix-build fish | source
    carapace nix-instantiate fish | source
    carapace nix-shell fish | source
    fzf --fish | source
    starship init fish | source
    zoxide init fish --cmd=cd | source
    direnv hook fish | source
    nix-your-shell fish | source
end
