#!/usr/bin/env zsh

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing

#---- prompt style - powerlevel10k ---#
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.zsh/powerlevel10k.custom.zsh ]] || source $HOME/.zsh/powerlevel10k.custom.zsh
