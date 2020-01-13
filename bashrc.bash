# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar &>/dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

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


export EDITOR=vim

# common
alias today='date +"%Y-%m-%d"'

if which youtube-dl &>/dev/null; then
    alias youtube-dl="youtube-dl --all-subs"
fi

if ! which realpath &>/dev/null && which python &>/dev/null; then
    alias realpath='python -c "import os, sys; print(os.path.realpath(sys.argv[1]))"'
fi

if which git &>/dev/null; then
    alias git-amend='git commit --amend -m "$(git log -1 --format=%B)"'
    alias git-branch='git branch | while read line; do
        desc=$(git config branch.$(echo "$line" | sed "s/\* //g").description)
        printf "%-8s\t\t$desc\n" "$line"
    done'
    export PS1='\[\033]0;\W\007\]\[\033[01;32m\]\w\[\033[01;36m\]`__git_ps1`\[\033[00m\]\$ '
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ $(uname) = Darwin ]; then
    . "$HOME/.config/macos.bash"
elif [ $(uname) = Linux ]; then
    . "$HOME/.config/linux.bash"
else
    . "$HOME/.config/other.bash"
fi
