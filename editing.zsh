#!/usr/bin/env zsh

#------- editing ------ -----------------------#
#--- Use vim line editor
bindkey -v
bindkey '\e[1~' beginning-of-line      # home key
bindkey '\e[4~' end-of-line            # end key

bindkey '\e[A' up-line-or-history      # up key
bindkey '\eOA' up-line-or-history      # up key
bindkey '\e[B' down-line-or-history    # down key
bindkey '\eOB' down-line-or-history    # down key
bindkey '\e[C' forward-char            # right key
bindkey '\eOC' forward-char            # right key
bindkey '\e[D' backward-char           # left key
bindkey '\eOD' backward-char           # left key

bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

bindkey '\e[2~' overwrite-mode         # insert key
bindkey '\e[3~' delete-char            # delete key

export KEYTIMEOUT=1
