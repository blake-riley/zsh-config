#!/usr/bin/env zsh

#------ SECURITY ------ -----------------------#
#--- ejson secrets
export EJSON_KEYDIR="${HOME}/.local/share/ejson"
export ZSH_SECRETS_FILE="${HOME}/.zsh/.secrets.ejson"

#--- Secrets for ENV export
export HOMEBREW_GITHUB_API_TOKEN="$(get_secret ${ZSH_SECRETS_FILE} HOMEBREW_GITHUB_API_TOKEN)"
export PAPERPILE_LIBRARY_ADDRESS="$(get_secret ${ZSH_SECRETS_FILE} PAPERPILE_LIBRARY_ADDRESS)"


#------ APPS ---------- -----------------------#
##--- fzf Fuzzy finder
() {
	if exist fzf; then
		local fzf_executable="$(readlink -f $(which fzf))"
		local fzf_prefix="${fzf_executable%/bin/fzf}"
		if [[ ! "$PATH" == *${fzf_prefix}/bin* ]]; then
			if [ -d "${fzf_prefix}" ]; then
				# export PATH="${PATH:+${PATH}:}${fzf_prefix}/bin"
				[[ $- == *i* ]] && source "${fzf_prefix}/shell/completion.zsh" 2> /dev/null
				source "${fzf_prefix}/shell/key-bindings.zsh"
			fi
		fi
	fi
}

##--- APBS
export PATH="${PATH}:$(dirname '/Applications/APBS.app/Contents/MacOS/apbs_term')"
##--- Amber
export AMBERHOME="${HOME}/opt/ambertools22/amber22"
export CPPTRAJHOME="${HOME}/opt/ambertools22/amber22_src/AmberTools/src/cpptraj"
export PATH="${AMBERHOME}/bin:${PATH}"
##--- Gromacs
# source /usr/local/share/gromacs/GMXRC.bash
##--- Rosetta
export ROSETTA3_DB="$(brew --prefix)/opt/rosetta/database"
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
