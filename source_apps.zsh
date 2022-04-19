#!/usr/bin/env zsh

#- scripts to source -- -----------------------#

#-- conda --------------------------#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
		. "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
	else
		export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<
# Don't activate the base environment of conda (let pyenv reign)
# conda config --set auto_activate_base false

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
