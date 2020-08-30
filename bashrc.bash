# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar &>/dev/null
# shopt -s nullglob &>/dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
# PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

export VIMINIT="source $HOME/.config/.vimrc"
export EDITOR=vim

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if which go &>/dev/null; then
    export PATH="$(go env GOPATH)/bin:$PATH"
    export GOPROXY=https://goproxy.cn
    export GO111MODULE=on
fi

# common
alias today='date +"%Y-%m-%d"'

if which youtube-dl &>/dev/null; then
    alias youtube-dl="youtube-dl --all-subs"
fi

if ! which realpath &>/dev/null && which python &>/dev/null; then
    alias realpath='python -c "import os, sys; print(os.path.realpath(sys.argv[1]))"'
fi

function git-review() (
    set -e
    git diff-index --quiet "${1:-HEAD}"
    commit_hash=$(git show-ref --head --hash "$1" | head -1)
    git checkout $commit_hash^ >/dev/null
    git checkout $commit_hash -- . >/dev/null
)

function __uh() {

    if [ "$PWD" = "$HOME" ]; then
        if [ -n "$USER" ]; then
            echo "$USER@$(hostname -s):"
        else
            echo "$(whoami)@$(hostname -s):"
        fi
    fi
}

if which git &>/dev/null; then
    export PS1='\[\033]0;\W\007\]`__wg`\[\033[01;32m\]`__uh`\w\[\033[01;36m\]`__git_ps1`\[\033[00m\]\$ '
    alias git-amend='git commit --amend -m "$(git log -1 --format=%B)"'
    alias git-branch='git branch | while read line; do
        desc=$(git config branch.$(echo "$line" | sed "s/\* //g").description)
        printf "%-8s\t\t$desc\n" "$line"
    done'
else
    export PS1='\[\033]0;\W\007\]\[\033[01;32m\]`__uh`\w\[\033[00m\]\$ '
fi

if [ $(uname) = Darwin ]; then
    OS_PATCH="$HOME/.config/macos.bash"
elif [ $(uname) = Linux ]; then
    OS_PATCH="$HOME/.config/linux.bash"
else
    OS_PATCH="$HOME/.config/other.bash"
fi

[ -f $OS_PATCH ] && . $OS_PATCH
