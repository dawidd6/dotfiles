# Exports
set -gx DEBFULLNAME "Dawid Dziurla"
set -gx DEBEMAIL "dawidd0811@gmail.com"
set -gx DEBHOME "$HOME/debian"
set -gx QUILT_PATCHES "debian/patches"
set -gx EDITOR "nvim"
set -gx LESS "-R"
set -gx PAGER "less"
set -gx MANPAGER "less"
set -gx LESSHISTFILE "$HOME/.cache/less/history"
set -gx STARSHIP_CONFIG "$HOME/.config/starship/config.toml"
set -gx SYSTEMD_EDITOR "$EDITOR"
set -gx BAT_THEME "TwoDark"
set -gx SNAPCRAFT_BUILD_ENVIRONMENT "lxd"
set -gx GEM_HOME "$HOME/.gem"
set -gx ELECTRON_TRASH "gvfs-trash"
set -gx GPG_TTY (tty)
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_DEVELOPER 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx HOMEBREW_NO_INSTALL_FROM_API 1
set -gx HOMEBREW_EDITOR "$EDITOR"
set -gx HOMEBREW_GITHUB_USER dawidd6
set -gx HOMEBREW_GITHUB_API_TOKEN (cat $HOME/.github 2>/dev/null)
set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" ""
set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" ""
set -gx PATH \
    "$HOME/bin" \
    "$PATH" \
    "/home/linuxbrew/.linuxbrew/bin" \
    "/home/linuxbrew/.linuxbrew/sbin"

# Aliases
alias sudo "sudo -E env \"PATH=$PATH\""
alias vi "nvim"
alias vim "nvim"
alias l "ls -lhA"
alias rm "trash"
alias dotfiles "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ssh "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias hub "gh"

# Abbreviations
abbr e "exit"
abbr more "less"
abbr sl "ls"
abbr add "sudo apt install"
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
abbr fishedit "$EDITOR $HOME/.config/fish/config.fish"
abbr nvimedit "$EDITOR $HOME/.config/nvim/init.vim"
abbr clip "xsel --clipboard"
abbr b "brew"
abbr brew-cd "cd (brew --repository)/Library/Homebrew"
abbr brew-cd-tap "cd (brew --repository dawidd6/tap)"
abbr brew-cd-core "cd (brew --repository homebrew/core)"
abbr mic-test "arecord -f cd - | aplay -"
abbr docker "podman"
abbr d "podman"
abbr p "podman"

# Colors
set fish_color_command green
set fish_color_param normal
set fish_color_error red --bold
set fish_color_normal normal
set fish_color_comment brblack
set fish_color_quote yellow

# Sources
starship init fish | source
zoxide init --cmd cd fish | source
