# Exports
set -gx DEBFULLNAME "Dawid Dziurla"
set -gx DEBEMAIL "dawidd0811@gmail.com"
set -gx DEBHOME "$HOME/debian"
set -gx QUILT_PATCHES "debian/patches"
set -gx EDITOR "nvim"
set -gx PAGER "less"
set -gx MANPAGER "less"
set -gx SYSTEMD_EDITOR "$EDITOR"
set -gx BAT_THEME "TwoDark"
set -gx SNAPCRAFT_BUILD_ENVIRONMENT "multipass"
set -gx GOPATH "$HOME/.go"
set -gx GEM_HOME "$HOME/.gem"
set -gx ANDROID_HOME "$HOME/android/sdk"
set -gx FLUTTER_ROOT "$HOME/.flutter"
set -gx ELECTRON_TRASH "gvfs-trash"
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_NO_EMOJI 1
#set -gx HOMEBREW_UPDATE_TO_TAG 1
set -gx HOMEBREW_DEVELOPER 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK 1
set -gx HOMEBREW_BINTRAY_USER "$USER"
set -gx HOMEBREW_BINTRAY_KEY (cat $HOME/.bintray)
set -gx HOMEBREW_GITHUB_USER "$USER"
set -gx HOMEBREW_GITHUB_API_TOKEN (cat $HOME/.github)
set -gx PATH \
    "$HOME/bin" \
    "$HOME/go/bin" \
    "$GEM_HOME/bin" \
    "$HOMEBREW_PREFIX/bin" \
    "/usr/local/sbin" \
    "/usr/local/bin" \
    "/usr/sbin" \
    "/usr/bin" \
    "/sbin" \
    "/bin" \
    "/usr/games"

# Aliases
alias duscan 'docker run -it --rm -v $PWD:/workdir:ro dawidd6/debian-dev uscan --no-download -v --destdir /tmp'
alias sudo "sudo -s"
alias vim "nvim"
alias ls "ls --color=always"
alias lsa "ls --color=always -A"
alias rm "trash"
alias dotfiles "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias keys "git --git-dir=$HOME/.keys --work-tree=$HOME"

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
abbr upgradable "apt list --upgradable"
abbr belongs "apt-file search"
abbr contents "apt-file list"
abbr show "apt show"
abbr list "dpkg -l"
abbr list-grep "dpkg -l | grep"
abbr d "docker"
abbr dr "docker run -it --rm"
abbr di "docker images"
abbr dp "docker ps -a"
abbr de "docker exec -it"
abbr g "git"
abbr ga "git add"
abbr gc "git commit -S -m"
abbr gca "git commit -S --amend --no-edit"
abbr gcae "git commit -S --amend --edit"
abbr gs "git status -u"
abbr gt "git tag"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr gh "git checkout"
abbr ghm "git checkout master"
abbr gb "git branch -a"
abbr gf "git fetch"
abbr gp "git push"
abbr gfo "git fetch origin"
abbr gpo "git push origin -u"
abbr ansible-playbook-local "ansible-playbook -K --connection local -i localhost,"
abbr ansible-playbook-docker "env ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -K -i user@172.17.0.2,"
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
abbr brew-cd "cd (brew --repository)"
abbr brew-cd-tap "cd (brew --repository \$USER/tap)"
abbr brew-cd-core "cd (brew --repository homebrew/core)"
abbr snapshot-create "sudo lvcreate --snapshot --name=root_snapshot --size 30G /dev/ubuntu-vg/root"
abbr snapshot-remove "sudo lvremove /dev/ubuntu-vg/root_snapshot"
abbr snapshot-restore "sudo lvconvert --merge /dev/ubuntu-vg/root_snapshot"
abbr snapshot-list "sudo lvs | awk 'NR==1; /snapshot/'"

# Colors
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Homebrew
if test -d "$HOMEBREW_PREFIX" && test (id -u) -ne 0
    eval ("$HOMEBREW_PREFIX/bin/brew" shellenv)
end

# Prompt
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

# Interactive cd
function cdi -d 'interactively select directory while listing its content'
    while true
        find -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | env LC_ALL=C sort --reverse | fzf --exit-0 --no-sort --bind "left:execute(echo ..)+cancel" --bind "right:accept" --reverse --preview "ls $PWD/{}" --header "$PWD" --height 50% | read dir && test -n "$dir" && cd "$dir" || break
    end
end

# Title
function fish_title
end
