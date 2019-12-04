#!/usr/bin/env zsh

#--- Homebrew zsh completion
fpath=($HOME/.zsh-completions /usr/local/share/zsh-completions $fpath)

#----- zsh modules ---- -----------------------#
autoload -U compinit && compinit

#----- completion ----- -----------------------#
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'

setopt CORRECT                    # Spell check commands

setopt RC_EXPAND_PARAM            # Cast to expand arrays (e.g. foo${arr}bar)

setopt GLOB_COMPLETE              # If we have a glob this will expand it
setopt NUMERIC_GLOB_SORT          # If obviously numberic, expand as such
setopt EXTENDED_GLOB              # #~^ become glob expandable
setopt NOMATCH                    # If globbing fails, return error, rather than returning NULL arr

zstyle ':completion:*:default' list-prompt '%S%M matches%s'  # Don't prompt for a huge list, page it!
zstyle ':completion:*:default' menu 'select=0'               # Don't prompt for a huge list, menu it!

zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )' # more errors allowed for large words and fewer for small words

zstyle ':completion:*:corrections' format '%B%d (errors %e)%b' # Errors format

expand-or-complete-with-dots() {  # Fix for slow prompts
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

