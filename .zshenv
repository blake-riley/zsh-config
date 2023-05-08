#!/usr/bin/env zsh

export XDG_CONFIG_HOME="${HOME}/.config"

# Load in non-interactive functions
if [ -f "${XDG_CONFIG_HOME}/skhd/yabai_control_functions.zsh" ]; then
    source "${XDG_CONFIG_HOME}/skhd/yabai_control_functions.zsh";
fi

