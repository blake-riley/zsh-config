#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#--- Gromacs
# source /usr/local/share/gromacs/GMXRC.bash
#--- CCP4
# source /Applications/ccp4-7.0/bin/ccp4.setup-sh
#--- Phenix
# source /Applications/phenix-1.14-3260/phenix_env.sh
#-- pyenv-virtualenv --------------------------#
# source virtualenvwrapper.sh
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
#-- rbenv -------------------------------------#
eval "$(rbenv init -)"

#--- TeX fix --- ------ -----------------------#
#eval `/usr/libexec/path_helper -s`
