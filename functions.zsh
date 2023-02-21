#!/usr/bin/env zsh

function zsh_recompile {
  autoload -U zrecompile
  rm -f ~/.zsh/*.zwc
  [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
  [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

  for f in ~/.zsh/**/*.zsh; do
    [[ -f $f ]] && zrecompile -p $f
    [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
  done

  [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
  [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old

  source ~/.zshrc
}

function gitignoreio() {
  # From https://docs.gitignore.io/install/command-line
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}

function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1  ;;
          *.tar.gz)    tar xzf $1  ;;
          *.bz2)       bunzip2 $1  ;;
          *.rar)       unrar x $1    ;;
          *.gz)        gunzip $1   ;;
          *.tar)       tar xf $1   ;;
          *.tbz2)      tar xjf $1  ;;
          *.tgz)       tar xzf $1  ;;
          *.zip)       unzip $1   ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1  ;;
          *.ab)        ( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 $1 ) |  tar xvzf - ;;
          *)        echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

function pg_start {
  /usr/local/bin/pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
}

function pg_stop {
  /usr/local/bin/pg_ctl -D /usr/local/var/postgres stop -s -m fast
}

function mysql_start {
  mysql.server start
}

function mysql_stop {
  mysql.server stop
}

function ss {
  if [ -e script/server ]; then
    script/server $@
  else
    script/rails server $@
  fi
}

# function sc {
#   if [ -e script/console ]; then
#     script/console $@
#   else
#     script/rails console $@
#   fi
# }

function fix_airplay {
  sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' |awk '{print $1}'`
}

# Detect empty enter, execute git status if in git dir
# code from: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/magic-enter/magic-enter.plugin.zsh
magic-enter () {
        if [[ -z $BUFFER ]]; then
          if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            echo -ne '\n'
            git status 
            echo -ne '\n\n'
          fi
          zle redisplay
        else
          zle accept-line
        fi
}
zle -N magic-enter
bindkey "^M" magic-enter

function exist { command -v $1 1>/dev/null 2>&1 }  # POSIX standard
function exists { which $1 &> /dev/null }  # works for zsh, csh

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
