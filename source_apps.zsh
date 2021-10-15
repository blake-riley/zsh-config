#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#-- pyenv-virtualenv --------------------------#
if command -v pyenv 1>/dev/null 2>&1; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)";
	eval "$(pyenv init -)";
fi
if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then eval "$(pyenv virtualenv-init -)"; fi
#-- rbenv -------------------------------------#
if command -v rbenv 1>/dev/null 2>&1; then eval "$(rbenv init -)"; fi

#--- Gromacs
# source /usr/local/share/gromacs/GMXRC.bash
#--- CCP4
# source /Applications/ccp4-7.1/bin/ccp4.setup-sh
#--- Phenix
# source /Applications/phenix-1.19.2-4158/phenix_env.sh

#--- TeX fix --- ------ -----------------------#
#eval `/usr/libexec/path_helper -s`
