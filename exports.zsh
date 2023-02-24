#!/usr/bin/env zsh

#------ SECURITY ------ -----------------------#
export GPG_TTY="$(tty)"

#------ COMPILING ----- -----------------------#
# export ARCHFLAGS='-arch x86_64'

#------ EDITING ------- -----------------------#
export EDITOR=vim

#------ PACKAGE MANAGER -----------------------#
export PATH="${HOME}/bin:${PATH}"  # personal apps
export PATH="${HOME}/.iterm2/bin:${PATH}"  # iterm2_shell_integrations

# Homebrew path
CPU=$(uname -p)
if [[ "$CPU" == "arm" ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
	alias oldbrew=/usr/local/bin/brew
else
	export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# export HOMEBREW_BUILD_FROM_SOURCE=1
hostname=$(hostname | sed 's/.local//g')
case $hostname in
	*Tangor*)	unset HOMEBREW_CASK_OPTS ;;
	*)		export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications" ;;
esac

#------ LANGUAGES ----- -----------------------#
##--- Android ---
export ANDROID_HOME="/usr/local/opt/android-sdk"

##--- Ruby ---
if [[ $(uname -s) == Darwin ]] && $(command -v brew 1>/dev/null 2>&1); then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi
if command -v rbenv 1>/dev/null 2>&1; then eval "$(rbenv init -)"; fi

##--- Rust ---
export PATH="${HOME}/.cargo/bin:${PATH}"

##--- Haskell ---
#export PATH="${HOME}/.cabal/bin:${PATH}"  # Haskell

##--- Perl ---
#export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
#export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
#export PERL_MB_OPT="--install_base \"${HOME}/perl5\""
#export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"
#export PATH="${HOME}/perl5/bin${PATH+:}${PATH}"

##--- Python ---
###-- pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)";
	eval "$(pyenv init -)";
fi
if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then eval "$(pyenv virtualenv-init -)"; fi

###-- conda
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
# If .condarc already exists, assume the user has set their prefs correctly.
if [ command -v conda 1>/dev/null 2>&1 ] && [ ! -f "${HOME}/.condarc" ]; then
	conda config --set auto_activate_base false
fi

###-- pipenv
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

###-- pipx
export PATH="${HOME}/.local/bin:${PATH}"  # pipx
