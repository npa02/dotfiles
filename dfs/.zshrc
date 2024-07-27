# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Created by newuser for 5.8
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# HISTORY
HISTSIZE=2795
SAVEHIST=2795
HISTFILE="$HOME/.history"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt ALIASES

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]]    && source ~/.p10k.zsh
[[ -e ~/.profile ]]     && emulate sh -c 'source ~/.profile'
[[ -f ~/.aliases ]]     && source ~/.aliases

# Auto completions
if [[ -d ~/.zsh ]]; then
    # https://github.com/zsh-users/zsh-autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    fpath=(~/.zsh/completion $fpath)
    fpath=(~/.zsh/zsh-completions/src $fpath)
    autoload -Uz compinit && compinit -i
fi

# Default text editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Color for man-pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
# 'bat' as the default pager for 'man'
if type bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# Key binding
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[3~"  delete-char
# source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
source ~/.zkbd/keybindings
[[ -n ${key[Left]} ]]   && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]]  && bindkey "${key[Right]}" forward-char
# etc.

# fuzzy finder
source ~/.dotfiles/dfs/fzf/completion.zsh
source ~/.dotfiles/dfs/fzf/key-bindings.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.dotfiles/dfs/fzf-tab/fzf-tab.plugin.zsh
