# Blake Riley
# .zshrc
# 2015-02-09

###############################################
###############################################
#############   ZSH environment   #############
###############################################
###############################################

#------ powerline ----- -----------------------#
#pip install powerline-status
export PYTHON_REPO=/usr/local/lib/python2.7/site-packages
. $PYTHON_REPO/powerline/bindings/zsh/powerline.zsh

#------ oh my zsh ----- -----------------------#
export ZSH=$HOME/.oh-my-zsh
[[ -e $ZSH/themes/blake.zsh-theme ]] || { ln -s $HOME/.zsh-blake.zsh-theme $ZSH/themes/blake.zsh-theme }
ZSH_THEME="blake"
plugins=(osx git itunes)
source $ZSH/oh-my-zsh.sh

#----- zsh modules ---- -----------------------#
autoload -Uz compinit 
autoload -U promptinit zcalc zsh-mime-setup
autoload -U colors && colors
compinit
promptinit
zsh-mime-setup

#----- completion ----- -----------------------#
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle :compinstall filename '/Users/briley/.zshrc'

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

#------- history ------ -----------------------#
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000
HISTFILE=~/.history
SAVEHIST=1000000
setopt APPEND_HISTORY             # Append history to $HISTFILE
setopt INC_APPEND_HISTORY         # Append to history after every command
setopt SHARE_HISTORY              # Share history between multiple shells
setopt EXTENDED_HISTORY           # Save the time and how long a command ran
setopt HIST_IGNORE_DUPS           # Ignore sequential duplicate commands
setopt HIST_REDUCE_BLANKS         # Reduce redundant spaces
#setopt HIST_IGNORE_SPACE          # If a line starts with a space, don't save
#setopt HIST_NO_STORE              # If a line starts with a space, don't save
setopt HIST_VERIFY                # Show history commands before executing


#----- navigation ----- -----------------------#
setopt AUTO_CD                    # cd implied if a directory is input
setopt AUTO_PUSHD                 # cd=pushd
setopt AUTO_NAME_DIRS             # Will use named dirs when possible
setopt PUSHD_MINUS                # ??? +=- ???
setopt PUSHD_SILENT               # No more annoying pushd messages...
setopt PUSHD_TO_HOME              # blank pushd goes to home

#---- prompt style ---- -----------------------#
setopt PROMPT_SUBST               # Do prompt command processing
# host_color=yellow #166=orange
# history_color=magenta
# user_color=cyan
# root_color=red
# directory_color=blue
# error_color=red
# jobs_color=green
# userprompt_color=green

# user_prompt="%{$fg_bold[$user_color]%}%n@%{$reset_color%}"
# host_prompt="%{$fg_bold[$host_color]%}%m:%{$reset_color%}"
# jobs_prompt1="%{$fg_bold[$jobs_color]%}(%{$reset_color%}"
# jobs_prompt2="%{$fg[$jobs_color]%}%j%{$reset_color%}"
# jobs_prompt3="%{$fg_bold[$jobs_color]%})%{$reset_color%}"
# jobs_total="%(1j.${jobs_prompt1}${jobs_prompt2}${jobs_prompt3} .)"
# history_prompt1="%{$fg_bold[$history_color]%}[%{$reset_color%}"
# history_prompt2="%{$fg[$history_color]%}%h%{$reset_color%}"
# history_prompt3="%{$fg_bold[$history_color]%}]%{$reset_color%}"
# history_total="${history_prompt1}${history_prompt2}${history_prompt3}"
# error_prompt1="%{$fg_bold[$error_color]%}<%{$reset_color%}"
# error_prompt2="%{$fg[$error_color]%}%?%{$reset_color%}"
# error_prompt3="%{$fg_bold[$error_color]%}>%{$reset_color%}"
# error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"

# function prompt_char {
#     git branch >/dev/null 2>/dev/null && echo '±' && return
#     hg root >/dev/null 2>/dev/null && echo '☿' && return
#     echo '○'
# }

# function virtualenv_info {
#     [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
# }

# case "$TERM" in
#   (screen)
#     function precmd() { print -Pn "\033]0;S $TTY:t{%100<...<%~%<<}\007" }
#   ;;
#   (xterm)
#     directory_prompt=""
#   ;;
#   (*)
#     directory_prompt="%{$fg[$directory_color]%}%~%{$reset_color%} "
#   ;;
# esac

# if [[ $USER == root ]]; then
#     post_prompt="%{$fg_bold[$root_color]%}%#%{$reset_color%}"
# else
#     post_prompt="%{$fg_bold[$userprompt_color]%}%#%{$reset_color%}"
# fi

# PROMPT="
# ${jobs_total}${history_total} ${user_prompt}${host_prompt}${directory_prompt}${error_total}${post_prompt}
# $(virtualenv_info)%(!.$(prompt_char).$(prompt_char)) "


#------- modules ------ -----------------------#
setopt NO_CLOBBER                 # Don't allow > to overwrite file
setopt HIST_ALLOW_CLOBBER         # But record it as a clobber in hist

#setopt MULTIOS                    # Now we can pipe to multiple outputs!

setopt BEEP                       # Beep on error

setopt NOTIFY                     # Notify when background process updates


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

# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% COMMAND]%  %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select
export KEYTIMEOUT=1

#---------------------- -----------------------#

###############################################
###############################################
###########   Personal Environment   ##########
###############################################
###############################################

#-------- PATH -------- -----------------------#
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH

#------ ls family ----- -----------------------#
alias ls='ls -hFG'      # add colors for filetype recognition
alias ll='ls -l'        # show in list
alias la='ls -Al'       # show hidden files
alias lx='ls -lXB'      # sort by extension
alias lk='ls -lSr'      # sort by size, biggest last
alias lc='ls -ltcr'     # sort by and show change time, most recent last
alias lu='ls -ltur'     # sort by and show access time, most recent last
alias lt='ls -ltr'      # sort by date, most recent last
alias lm='ls -al |more' # pipe through 'more'
alias lr='ls -lR'       # recursive ls
alias tree='tree -Csu'  # nice alternative to 'recursive ls'

#---- servers list ---- -----------------------#
alias msg='ssh -XY blaker@msgln4.its.monash.edu.au'
alias tambo='ssh -X briley@tambo.vlsci.unimelb.edu.au'
alias merri='ssh -X briley@merri.vlsci.unimelb.edu.au'
alias avoca='ssh -X briley@avoca.vlsci.unimelb.edu.au'
alias pxgrid='ssh -XY blake@pxgrid.med.monash.edu.au'
alias orchard='ssh -XY blake@orchard.med.monash.edu.au'
alias banaNAS='ssh blake@10.0.0.241'
alias jazz='ssh blake@jazz.local -p 2222'
alias citron='ssh ubuntu@118.138.241.76'
alias avoca_qs="ssh briley@avoca.vlsci.unimelb.edu.au 'squeue -l -u briley -o '\''%.7i %.4P %.30j %.8u %.8T %.9M %.9l %.3D %R'\'''"
#alias avoca_qs="ssh briley@avoca.vlsci.unimelb.edu.au 'squeue -u briley -o '\''%i %j %B %a %u %U %g %G %D %C %T %S %e %l %M %L %k %s'\'''"
alias avoca_qs_all="ssh briley@avoca.vlsci.unimelb.edu.au 'squeue -l -u briley -o '\''%i %P %j %u %T %M %l %D %R'\'''"
alias iview="PATH=$PATH:/Users/briley/GitHub/python-iview iview-cli"
alias md_manager="cd /Users/briley/GitHub/md_manager/md_manager; python manage.py runserver"

#- scripts to source -- -----------------------#
#--- Android
export ANDROID_HOME=/usr/local/opt/android-sdk
#--- Gromacs
source /usr/local/share/gromacs/GMXRC.zsh
#--- Amber
export PATH=/usr/local/amberbin/amber12/bin:$PATH
export AMBERHOME=/usr/local/amberbin/amber12
#--- Phenix
source /Volumes/DATA/Applications/phenix-1.9-1692/phenix_env.sh
#--- Homebrew
fpath=(/usr/local/share/zsh-completions $fpath)
#--- VMD
export VMDDIR="/Applications/VMD-1.9.2.app/Contents/vmd"
alias vmd='/Applications/VMD-1.9.2.app/Contents/vmd/vmd_MACOSXX86'
alias vmdtext='/Applications/VMD-1.9.2.app/Contents/vmd/vmd_MACOSXX86 -dispdev text'
#-- virtualenvwrapper - -----------------------#
source virtualenvwrapper.sh


#- personal commands -- -----------------------#
#--- timing 
function timing() {
  while [ -n "$1" ]; do
    if [ ! -e "$1" ]; then
      echo "'$1' not found; exiting"
      return
    fi

    local file=`basename -- "$1"`

    # Chop trailing '/' if there
    file=${file%/}

    echo "'$file' timing:"
    grep TIMING $1 | tail
    shift
  done
}

alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

#--- final commands --- -----------------------#
archey --orange
