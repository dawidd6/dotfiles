# Exports
set -gx DEBFULLNAME "Dawid Dziurla"
set -gx DEBEMAIL "dawidd0811@gmail.com"
set -gx DEBHOME "$HOME/debian"
set -gx QUILT_PATCHES "debian/patches"
set -gx EDITOR "nvim"
set -gx LESS "-R"
set -gx PAGER "less"
set -gx MANPAGER "less"
set -gx SYSTEMD_EDITOR "$EDITOR"
set -gx BAT_THEME "TwoDark"
set -gx SNAPCRAFT_BUILD_ENVIRONMENT "multipass"
set -gx GEM_HOME "$HOME/.gem"
set -gx ELECTRON_TRASH "gvfs-trash"
set -gx GPG_TTY (tty)
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_DEVELOPER 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx HOMEBREW_NO_INSTALL_FROM_API 1
set -gx HOMEBREW_EDITOR "$EDITOR"
set -gx HOMEBREW_GITHUB_USER "$USER"
set -gx HOMEBREW_GITHUB_API_TOKEN (cat $HOME/.github 2>/dev/null)
set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" ""
set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" ""
set -gx PATH \
    "$HOME/bin" \
    "/usr/local/sbin" \
    "/usr/local/bin" \
    "/usr/sbin" \
    "/usr/bin" \
    "/sbin" \
    "/bin" \
    "/snap/bin" \
    "/home/linuxbrew/.linuxbrew/bin" \
    "/home/linuxbrew/.linuxbrew/sbin"

# Aliases
alias sudo "sudo -E env \"PATH=$PATH\""
alias vi "nvim"
alias vim "nvim"
alias ls "ls --color"
alias lsa "ls -A"
alias rm "trash"
alias dotfiles "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias keys "git --git-dir=$HOME/.keys --work-tree=$HOME"
alias ssh "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# Abbreviations
abbr dchr "dch --release --vendor debian ''"
abbr udd-psql "env PGPASSWORD=udd-mirror psql --host=udd-mirror.debian.net --user=udd-mirror udd"
abbr e "exit"
abbr more "less"
abbr sl "ls"
abbr add "sudo apt install"
abbr src "apt source"
abbr purge "sudo apt remove --purge"
abbr autopurge "sudo apt autoremove --purge"
abbr update "sudo apt update"
abbr upgrade "sudo apt full-upgrade"
abbr search "apt search"
abbr clean "sudo apt clean && sudo apt autoclean"
abbr outdated "apt list --upgradable"
abbr belongs "apt-file search"
abbr contents "apt-file list"
abbr show "apt show"
abbr list "dpkg -l"
abbr list-grep "dpkg -l | grep"
abbr g "git"
abbr ga "git add"
abbr gc "git commit -m"
abbr gca "git commit --amend --no-edit"
abbr gcae "git commit --amend --edit"
abbr gs "git status -u"
abbr gt "git tag"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr gh "git checkout"
abbr ghm "git checkout (git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@origin/@@')"
abbr gb "git branch -a"
abbr gf "git fetch"
abbr gp "git push"
abbr gfo "git fetch origin"
abbr gpo "git push origin -u"
abbr suspend "systemctl suspend"
abbr fishrc "source $HOME/.config/fish/config.fish"
abbr fishedit "$EDITOR $HOME/.config/fish/config.fish"
abbr nvimedit "$EDITOR $HOME/.config/nvim/init.vim"
abbr clip "xsel --clipboard"
abbr pastefile "pastebinit -b paste.ubuntu.com -i"
abbr b "brew"
abbr bi "brew install"
abbr bu "brew update"
abbr be "brew edit"
abbr brew-cd "cd (brew --repository)/Library/Homebrew"
abbr brew-cd-tap "cd (brew --repository dawidd6/tap)"
abbr brew-cd-core "cd (brew --repository homebrew/core)"
abbr mic-test "arecord -f cd - | aplay -"
abbr snapshot-create "sudo lvcreate --snapshot --name=root_snapshot --size 50G vgubuntu/root"
abbr snapshot-remove "sudo lvremove vgubuntu/root_snapshot"
abbr snapshot-restore "sudo lvconvert --merge vgubuntu/root_snapshot"
abbr snapshot-list "sudo lvs | awk 'NR==1; /snapshot/'"
abbr docker "podman"
abbr d "podman"
abbr p "podman"

# Completions
#set fish_complete_path "/home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d" $fish_complete_path

# Colors
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Prompt
function fish_prompt
    # disable greeting
    set fish_greeting

    # get last status
    set last_status $status

    # get cwd
    set cwd (string replace "$HOME" "~" $PWD)
    set cwd_tokenized (string split -n / "$cwd")
    set cwd_count (count $cwd_tokenized)

    if test $cwd_count -gt 2
        set cwd "$cwd_tokenized[-2]/$cwd_tokenized[-1]"
    end

    # in container
    if test -f /run/.containerenv || test -f /.dockerenv
        echo -n "📦 "
    end

    # current date
    set_color --bold brblue
    echo -n (date '+%a %d %b')" "

    # current time
    set_color --bold brblue
    echo -n (date +%H:%M:%S)" "

    # background job
    if jobs --quiet
        set_color --bold blue
        echo -n "job "
    end

    # status symbol
    if test $last_status -eq 0
        set_color --bold green
    else
        set_color --bold red
    end
    echo -n "➜  "

    # current working directory
    set_color --bold white
    echo -n "$cwd "

    # git prompt
    if command -v git > /dev/null 2>&1 && git rev-parse > /dev/null 2>&1
        set -l gbare (git rev-parse --is-bare-repository)
        set -l gstash (git stash list 2>/dev/null)
        set -l gtag (git tag --points-at HEAD 2>/dev/null | head -n1)
        set -l gbranch (git symbolic-ref -q --short HEAD)
        set -l gahead (git rev-list --count '@{u}..' 2>/dev/null)
        set -l gbehind (git rev-list --count '..@{u}' 2>/dev/null)
        set -l gstatus (git status -s 2>/dev/null)

        if "$gbare"
            set_color --bold brblack
            echo -n "bare "
        end

        if test -n "$gstash"
            set_color --bold yellow
            echo -n "stash "
        end

        if test -n "$gtag"
            set_color --bold magenta
            echo -n "$gtag "
        end

        if test -n "$gbranch"
            set_color --bold cyan
            echo -n "$gbranch "
        end

        if test -n "$gahead" && test "$gahead" -gt 0
            set_color --bold brred
            echo -n "⇡ $gahead "
        end

        if test -n "$gbehind" && test "$gbehind" -gt 0
            set_color --bold brred
            echo -n "⇣ $gbehind "
        end

        if test -z "$gstatus"
            set_color --bold green
            echo -n "✓ "
        else
            set_color --bold yellow
            echo -n "✗ "
        end
    end

    # finalize prompt
    set_color normal
    echo -n " "
end

# Title
function fish_title
    set -q argv[1] || set argv fish
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    echo (basename (prompt_pwd)): $argv
end

# Greeting
function fish_greeting
end

