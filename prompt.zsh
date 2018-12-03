#!/usr/bin/env zsh

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing

#---- prompt style - powerlevel9k ---#
POWERLEVEL9K_MODE="nerdfont-complete"
source $HOME/.zsh/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='red'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='white'
POWERLEVEL9K_VI_COMMAND_MODE_STRING="[CMD]"
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='gray'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='green'
POWERLEVEL9K_VI_INSERT_MODE_STRING="[INS]"

################################################################
# Segment to display pyenv information
# https://github.com/pyenv/pyenv#choosing-the-python-version
PYTHON_ICON=$'\UF81F' # $'\U1F40D' # $'\xF0\x9F\x90\x8D'
GLOBAL_ICON=$'\UF0AC'
LOCAL_ICON=$'\UE5FC'
SHELL_ICON=$'\UF489'
set_default POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW false
prompt_pyenv() {
  # First, check if local pyenv is set.
  if [[ -n "$PYENV_VERSION" ]]; then
    "$1_prompt_segment" "$0" "$2" "green" "$DEFAULT_COLOR" "$PYENV_VERSION $SHELL_ICON $PYTHON_ICON"
  elif [ $commands[pyenv] ]; then
    # We're either local or global.
    # Get info about the global stack.
    local pyenv_root="$(pyenv root)"
    if [[ -f "${pyenv_root}/version" ]]; then
      local pyenv_global="$(pyenv version-file-read ${pyenv_root}/version)"
    fi
    # Get info about the current stack, and format it.
    local pyenv_version_name="$(pyenv version-name)"
    local pyenv_version_arr=(${(@s/:/)pyenv_version_name})
    local pyenv_version_repr="${pyenv_version_arr}"
    if [[ ${#pyenv_version_arr} -gt 1 ]]; then
      pyenv_version_repr="${pyenv_version_arr[1]} (${(l:${#pyenv_version_arr}-1::+:)})"
    fi

    # Are we in a pyenv local stack?
    if [[ "${pyenv_version_name}" != "${pyenv_global}" ]]; then
      "$1_prompt_segment" "$0" "$2" "green" "$DEFAULT_COLOR" "$pyenv_version_repr $LOCAL_ICON $PYTHON_ICON"
    elif [[ "${POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW}" == "true" ]]; then
      "$1_prompt_segment" "$0" "$2" "green" "$DEFAULT_COLOR" "$pyenv_version_repr $GLOBAL_ICON $PYTHON_ICON"
    else
      "$1_prompt_segment" "$0" "$2" "green" "$DEFAULT_COLOR" "$GLOBAL_ICON $PYTHON_ICON"
    fi
  fi
}

# #### DEFAULT ####
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
# #### ####### ####

POWERLEVEL9K_CONTEXT_TEMPLATE="%n@%m" # Default is user@host "%n@%m", we may want to override if we're also using a user segment

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode background_jobs os_icon context_joined ssh dir dir_writable vcs newline status root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(pyenv time)
