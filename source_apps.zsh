#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#--- Gromacs
# source /usr/local/share/gromacs/GMXRC.bash
#--- CCP4
# source /Applications/ccp4-7.0/bin/ccp4.setup-sh
#--- Phenix
# source /usr/local/phenix-1.9-1692/phenix_env.sh

#-- pyenv-virtualenv --------------------------#
# source virtualenvwrapper.sh
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

#--- TeX fix --- ------ -----------------------#
#eval `/usr/libexec/path_helper -s`
