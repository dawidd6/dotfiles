if status is-interactive
    # Fixes
    set fish_complete_path $fish_complete_path "$FLOX_ENV/share/fish/vendor_completions.d"

    # Scripts
    fish_add_path ~/.bin

    # Colors
    set fish_color_command green
    set fish_color_param normal
    set fish_color_error red --bold
    set fish_color_normal normal
    set fish_color_comment brblack
    set fish_color_quote yellow

    # Exports
    set -gx EDITOR nvim
    set -gx PAGER less
    set -gx SHELL fish
    set -gx MANPATH ~/.cache/man:

    # Abbreviations
    abbr --add -- clip 'xsel --clipboard'
    abbr --add -- e exit
    abbr --add -- g git
    abbr --add -- ga 'git add'
    abbr --add -- gb 'git branch -a'
    abbr --add -- gc 'git commit -m'
    abbr --add -- gca 'git commit --amend --no-edit'
    abbr --add -- gcae 'git commit --amend --edit'
    abbr --add -- gd 'git diff'
    abbr --add -- gdc 'git diff --cached'
    abbr --add -- gf 'git fetch'
    abbr --add -- gfo 'git fetch origin'
    abbr --add -- gh 'git checkout'
    abbr --add -- gp 'git push'
    abbr --add -- gpo 'git push origin -u'
    abbr --add -- gs 'git status -u'
    abbr --add -- gt 'git tag'
    abbr --add -- p podman

    # Aliases
    alias vi nvim
    alias vim nvim
    alias eza 'eza --group-directories-first --group --header '\''--time-style=long-iso'\'''
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias l eza
    alias lt 'eza --tree'
    alias tree 'eza --tree'
    alias rm trash
    alias ssh 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

    # Functions
    function hub --wraps="gh"
        if command -q op
            command op plugin run -- gh $argv
        else
            command gh $argv
        end
    end
    function flox --wraps="flox"
        command flox $argv
        if contains -- $argv[1] install uninstall
            echo 'Generating man cache...'
            mandb -C (echo "MANDB_MAP $FLOX_ENV/share/man $HOME/.cache/man" | psub) --user-db --no-straycats --quiet --create
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
