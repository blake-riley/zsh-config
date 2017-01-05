#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#--- Gromacs
source /usr/local/share/gromacs/GMXRC.bash
#--- CCP4
# source /Applications/ccp4-7.0/bin/ccp4.setup-sh
#--- Phenix
# source /usr/local/phenix-1.9-1692/phenix_env.sh
#-- virtualenvwrapper - -----------------------#
source virtualenvwrapper.sh


#--- TeX fix --- ------ -----------------------#
#eval `/usr/libexec/path_helper -s`

#--- final commands --- -----------------------#
. $HOME/.zsh/archey.zsh --orange
