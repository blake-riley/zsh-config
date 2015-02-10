#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#--- Gromacs
source /usr/local/share/gromacs/GMXRC.zsh
#--- Phenix
source /Volumes/DATA/Applications/phenix-1.9-1692/phenix_env.sh
#-- virtualenvwrapper - -----------------------#
source virtualenvwrapper.sh


#--- final commands --- -----------------------#
. $HOME/.zsh/archey.zsh --orange
