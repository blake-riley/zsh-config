#!/usr/bin/env zsh

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing

#---- prompt style - powerlevel10k ---#
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.zsh/powerlevel10k.custom.zsh ]] || source $HOME/.zsh/powerlevel10k.custom.zsh

################################################################
# Segment to display pyenv information
# https://github.com/pyenv/pyenv#choosing-the-python-version
PYTHON_ICON=$'\UF81F' # $'\U1F40D' # $'\xF0\x9F\x90\x8D'
GLOBAL_ICON=$'\UF0AC'
LOCAL_ICON=$'\UE5FC'
SHELL_ICON=$'\UF489'
# set_default POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW false
prompt_my_pyenv() {
  # First, check if local pyenv is set.
  if [[ -n "$PYENV_VERSION" ]]; then
    p10k segment -b "green" -t "$PYENV_VERSION $SHELL_ICON $PYTHON_ICON"
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
      p10k segment -b "green" -t "$pyenv_version_repr $LOCAL_ICON $PYTHON_ICON"
    elif [[ "${POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW}" == "true" ]]; then
      p10k segment -b "green" -t "$pyenv_version_repr $GLOBAL_ICON $PYTHON_ICON"
    else
      p10k segment -b "green" -t "$GLOBAL_ICON $PYTHON_ICON"
    fi
  fi
}
