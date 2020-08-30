alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# NOTE: /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"

# NOTE: brew install bash-completion@2
if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

function __wg() {
    if [[ -f "/var/run/wireguard/wg0.name" ]]; then
        echo '*'
    fi
}

# if [ "$(pwd)" = "$HOME" ]; then
#     FINDER=$(osascript -e 'tell application "Finder"' -e "${1-1} <= (count Finder windows)" -e "get POSIX path of (target of window ${1-1} as alias)" -e 'end tell' 2>/dev/null)
#     if [ "$FINDER" = "" ]; then
#         cd "$HOME/Documents"
#     else
#         cd "$FINDER"
#     fi
# fi
