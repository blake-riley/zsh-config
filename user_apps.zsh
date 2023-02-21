#!/usr/bin/env zsh

#------ SECURITY ------ -----------------------#
#--- ejson secrets
export EJSON_KEYDIR="${HOME}/.local/share/ejson"

#------ APPS ---------- -----------------------#
##--- fzf Fuzzy finder
fzf_prefix="$(brew --prefix fzf)"
if [[ ! "$PATH" == *${fzf_prefix}/bin* ]]; then
	if [ -d "${fzf_prefix}" ]; then
		# export PATH="${PATH:+${PATH}:}${fzf_prefix}/bin"
		[[ $- == *i* ]] && source "${fzf_prefix}/shell/completion.zsh" 2> /dev/null
		source "${fzf_prefix}/shell/key-bindings.zsh"
	fi
fi

##--- APBS
export PATH="${PATH}:$(dirname '/Applications/APBS.app/Contents/MacOS/apbs_term')"
##--- Amber
export AMBERHOME="/sw/amber18"
export AMBER_PREFIX="/sw/amber18"
export PATH="${AMBERHOME}/bin:${PATH}"
##--- Gromacs
# source /usr/local/share/gromacs/GMXRC.bash
##--- Rosetta
if $(command -v brew 1>/dev/null 2>&1) && $(brew ls --versions rosetta 1>/dev/null); then
	export ROSETTA3_DB="$(brew --prefix rosetta)/database"
fi
##--- CCP4
# source /Applications/ccp4-7.1/bin/ccp4.setup-sh
##--- Phenix
# source /Applications/phenix-1.19.2-4158/phenix_env.sh
##--- XDS
export PATH="${PATH}:/opt/xds/bin"

##--- Kubernetes (arkade k3s)
export PATH="${PATH}:${HOME}/.arkade/bin"

##--- TeX fix
#eval `/usr/libexec/path_helper -s`
