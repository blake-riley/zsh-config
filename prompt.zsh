#!/usr/bin/env zsh

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing

#------ powerline ----- -----------------------#
. ${HOME}/.pyenv/versions/tools-3/lib/python3.?/site-packages/powerline/bindings/zsh/powerline.zsh

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
L_SEGMENT_SEPARATOR=''
R_SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_lsegment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$L_SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_rsegment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG == 'NONE' ]]; then
    echo -n " %{%F{$1}%}$R_SEGMENT_SEPARATOR%{$bg$fg%} "
  elif [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{%K{$CURRENT_BG}%F{$1}%}$R_SEGMENT_SEPARATOR%{$bg$fg%} "
    # echo -n " %{$bg%F{$CURRENT_BG}%}$R_SEGMENT_SEPARATOR%{$fg%} "
  else
    # echo -n "%{$bg%}%{$fg%} "
    echo -n " %{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_lend() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$L_SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_rend() {
  echo -n " %{%k%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_lsegment black default "%(!.%{%F{yellow}%}.)$USER@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_rsegment yellow black
    else
      prompt_rsegment green black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_rsegment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_rsegment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_rsegment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_rsegment red black
        st='±'
      elif `hg st | grep -q "^(M|A)"`; then
        prompt_rsegment yellow black
        st='±'
      else
        prompt_rsegment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_lsegment blue black '%~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_rsegment blue black "(`basename $virtualenv_path`)"
  fi
}

# pyenv: current working pyenv locals
prompt_pyenv() {
  # First, abort if virtualenv is working...
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    return
  fi

  # Next, determine the local pyenvs
  if $(pyenv -v >/dev/null 2>&1); then
    local locals=($(pyenv local 2>/dev/null))
    if [[ -n $locals ]]; then
      prompt_rsegment blue black
      echo -n "\xF0\x9F\x90\x8D  "
      if [[ ${#locals} -gt 1 ]]; then
        echo -n "${locals[1]} (${(l:${#locals}-1::+:)})"
      else
        echo -n "${locals}"
      fi
    fi
  fi
}

# ZLE status (http://paulgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/)
vim_ins_mode=( green gray "[INS]" )
vim_cmd_mode=( white red "[CMD]" )
vim_mode=( "${vim_ins_mode[@]}" )

function zle-keymap-select {
  case "$KEYMAP" in
    (vicmd)
      vim_mode=( "${vim_cmd_mode[@]}" )
      ;;
    (main|viins)
      vim_mode=( "${vim_ins_mode[@]}" )
      ;;
    (*)
      vim_mode=( red black "[UNK]" )
      ;;
  esac
  zle reset-prompt
}

# function zle-line-finish {
#   vim_mode=( "${vim_ins_mode[@]}" )
# }

zle -N zle-keymap-select
# zle -N zle-line-finish

# function TRAPINT() {
#   vim_mode=( "${vim_ins_mode[@]}" )
#   return $(( 128 + $1 ))
# }

function _recover_line_or_else() {
  if [[ -z $BUFFER && $CONTEXT = start && $zsh_eval_context = shfunc
        && -n $ZLE_LINE_ABORTED
        && $ZLE_LINE_ABORTED != $history[$((HISTCMD-1))] ]]; then
    LBUFFER+=$ZLE_LINE_ABORTED
    unset ZLE_LINE_ABORTED
  else
    zle .$WIDGET
  fi
}
zle -N up-line-or-history _recover_line_or_else

function _zle_line_finish() {
  vim_mode=( "${vim_ins_mode[@]}" )
  # ZLE_LINE_ABORTED=$BUFFER
}
zle -N zle-line-finish _zle_line_finish


prompt_zlestatus() {
  prompt_lsegment $vim_mode[1] $vim_mode[2] $vim_mode[3]
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_lsegment black default "$symbols"
}

## Main prompt
build_lprompt() {
  RETVAL=$?
  prompt_zlestatus
  prompt_status
  prompt_context
  prompt_dir
  prompt_lend
}

build_rprompt() {
  prompt_git
  prompt_hg
  prompt_virtualenv
  prompt_pyenv
  prompt_rend
}

PROMPT='%{%f%b%k%}$(build_lprompt) '
RPROMPT=' $(build_rprompt)'
