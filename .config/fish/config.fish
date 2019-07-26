# TODO organize by programs
#
# Exports
#####################################################
# Debian
set -x DEBFULLNAME "Dawid Dziurla"
set -x DEBEMAIL "dawidd0811@gmail.com"
set -x DEBHOME "$HOME/debian"
set -x QUILT_PATCHES "debian/patches"

# Flutter
set -x FLUTTER_ROOT "$HOME/.flutter"

# Brew
set -x BREW_HOME "/home/linuxbrew/.linuxbrew"

# GTK no CSD
if test -f "/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0"
    set -x GTK_CSD 0
    set -x LD_PRELOAD "/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0"
end

# Misc
set -x EDITOR "nvim"
set -x PAGER "bat"
set -x MANPAGER "less"
set -x SYSTEMD_EDITOR "$EDITOR"
set -x BAT_THEME "TwoDark"
set -x ANDROID_HOME "$HOME/android/sdk"
set -x ELECTRON_TRASH "gvfs-trash"
set -x SNAPCRAFT_BUILD_ENVIRONMENT "multipass"
set -x CGO_ENABLED 0

# PATH
set -x PATH \
    "$HOME/bin" \
    "/snap/bin" \
    "$ANDROID_HOME/tools" \
    "$ANDROID_HOME/platform-tools" \
    "$ANDROID_HOME/flutter/bin" \
    "$HOME/go/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "/usr/local/sbin:/usr/local/bin" \
    "/usr/sbin:/usr/bin" \
    "/sbin:/bin" \
    "/usr/games"

# Colors
#####################################################
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Prompt
#####################################################
function fish_prompt
    set fish_greeting
    set last_status $status

    # get cwd
    set cwd (string replace "$HOME" "~" $PWD)
    set cwd_tokenized (string split -n / "$cwd")
    set cwd_count (count $cwd_tokenized)

    if test $cwd_count -gt 2
        set cwd "$cwd_tokenized[-2]/$cwd_tokenized[-1]"
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
    if git rev-parse > /dev/null 2>&1
        set -l gbare (git rev-parse --is-bare-repository)
        set -l gstash (git stash list 2>/dev/null)
        set -l gtag (git tag --points-at HEAD 2>/dev/null)
        set -l gbranch (git symbolic-ref -q --short HEAD)
        set -l gstatus (git status -s 2>/dev/null)

        if "$gbare"
            set_color --bold brblack
            echo -n "bare "
        end

        if test -n "$gstash"
            set_color --bold yellow
            echo -n "$gstash "
        end

        if test -n "$gtag"
            set_color --bold magenta
            echo -n "$gtag "
        end

        if test -n "$gbranch"
            set_color --bold cyan
            echo -n "$gbranch "
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

function fish_title
end

# Aliases
#####################################################
alias duscan 'docker run -it --rm -v $PWD:/workdir:ro dawidd6/debian-dev uscan --no-download -v --destdir /tmp'
alias ls "ls --color=always"
alias lsa "ls --color=always -A"
alias vim "nvim"
alias rm "trash"
alias dot "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Abbreviations
#####################################################
abbr add "sudo apt install"
abbr src "apt source"
abbr purge "sudo apt remove --purge"
abbr autopurge "sudo apt autoremove --purge"
abbr update "sudo apt update"
abbr upgrade "sudo apt full-upgrade"
abbr search "apt search"
abbr clean "sudo apt clean && sudo apt autoclean"
abbr upgradable "apt list --upgradable"
abbr show "apt show"
abbr list "dpkg -l | grep"
abbr belongs "apt-file search"
abbr contents "dpkg -L"

abbr d "docker"
abbr dr "docker run -it --rm"
abbr di "docker images"
abbr dp "docker ps -a"
abbr de "docker exec -it"

abbr g "git"
abbr ga "git add"
abbr gc "git commie"
abbr gca "git amend"
abbr gs "git status"
abbr gt "git tag"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr gh "git checkout"
abbr gb "git branch -a"
abbr gfo "git fetch origin"

abbr e "exit"
abbr more "less"
abbr cat "bat"
abbr suspend "systemctl suspend"
abbr sl "ls"
abbr fishrc "source $HOME/.config/fish/config.fish"
abbr fishedit "$EDITOR $HOME/.config/fish/config.fish"
abbr clip "xclip -selection clipboard"
abbr grep-baza "grep --binary --text -Ri"
abbr dchr "dch --release --vendor debian ''"

# Brew
#####################################################
# Install if isn't already
if not test -d "$BREW_HOME"
    echo "Installing brew"
    sh -c "(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
end

# Export variables
eval ("$BREW_HOME/bin/brew" shellenv)

# Add completions
set fish_complete_path "$BREW_HOME/share/fish/vendor_completions.d" $fish_complete_path
