#!/usr/bin/env zsh

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

#---- pip upgrade ----- -----------------------#
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U"

#------- copying ------ -----------------------#
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

#---- applications ---- -----------------------#
#--- VMD
alias vmd='/Applications/VMD-1.9.4.app/Contents/vmd/vmd_MACOSXX86'
alias vmdtext='/Applications/VMD-1.9.4.app/Contents/vmd/vmd_MACOSXX86 -dispdev text'
alias catdcd='/Applications/VMD-1.9.4.app/Contents/vmd/plugins/MACOSXX86/bin/catdcd5.2/catdcd'
#--- coot
alias coot='/Applications/ccp4-7.0/coot.app/Contents/MacOS/coot'
alias pymol='/Applications/PyMOL.app/Contents/MacOS/PyMOL'
