# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# HISTORY RECORDING
# See bash(1) for more options
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="history:hist:ls:la:ll:pwd:clear:cl:"
# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1400
HISTFILESIZE=2700
HISTFILE="$HOME/.history"

# Shorten the current directory path shown on terminal
PROMPT_DIRTRIM=2

# Auto cd to directories when only path is given as cmd
shopt -s autocd
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Expand alias within a script
shopt -s expand_aliases

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export RCUTILS_COLORIZED_OUTPUT=1

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ALIAS DEFINITIONS
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.aliases ] && source ~/.aliases
# [ -f ~/bcr2_setup/bldr.bashrc ] && source ~/bcr2_setup/bldr.bashrc

# Auto-completions / suggestions
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Git completion
if [ -f "/usr/share/git/completion/git-completion.bash" ]; then
    source /usr/share/git/completion/git-completion.bash
    __git_complete g __git_main
    __git_complete gc _git_checkout
    __git_complete gp _git_pull
#else
#    echo "Error loading git completions"
fi

# Fuzzy finder FZF key-bindings and completion
source ~/.dotfiles/dfs/fzf/completion.bash
source ~/.dotfiles/dfs/fzf/key-bindings.bash
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Default text editor
if [ -x /usr/bin/nvim ]; then
    export VISUAL=nvim
elif [ -x /usr/bin/vim ]; then
    export VISUAL=vim
elif [ -x /usr/bin/vi ]; then
    export VISUAL=vi
fi
export EDITOR="$VISUAL"

# 'bat' as the default pager for 'man'
if [ -x /usr/bin/bat ]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
