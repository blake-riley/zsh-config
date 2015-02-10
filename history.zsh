#!/usr/bin/env zsh

#------- history ------ -----------------------#
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000
HISTFILE=~/.zsh_history
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
