#!/usr/bin/env zsh

#----- navigation ----- -----------------------#
setopt AUTO_CD                    # cd implied if a directory is input
setopt AUTO_PUSHD                 # cd=pushd
setopt AUTO_NAME_DIRS             # Will use named dirs when possible
setopt PUSHD_MINUS                # ??? +=- ???
setopt PUSHD_SILENT               # No more annoying pushd messages...
setopt PUSHD_TO_HOME              # blank pushd goes to home

#------- modules ------ -----------------------#
setopt NO_CLOBBER                 # Don't allow > to overwrite file
setopt HIST_ALLOW_CLOBBER         # But record it as a clobber in hist

#setopt MULTIOS                    # Now we can pipe to multiple outputs!

setopt BEEP                       # Beep on error

setopt NOTIFY                     # Notify when background process updates
