#!/usr/bin/env zsh

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing

#---- prompt style - powerlevel9k ---#
source $HOME/.zsh/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MODE="nerdfont_complete"

POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='red'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='white'
POWERLEVEL9K_VI_COMMAND_MODE_STRING="[CMD]"
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='gray'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='green'
POWERLEVEL9K_VI_INSERT_MODE_STRING="[INS]"


# #### DEFAULT ####
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
# #### ####### ####

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode status root_indicator background_jobs context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs pyenv)
