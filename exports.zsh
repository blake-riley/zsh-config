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
if exist brew && [[ "$CPU" == "arm" ]]; then
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
# ruby<2.4 is not compatible with openssl@1.1 (https://github.com/rbenv/ruby-build/issues/1353#issuecomment-573414540)
#   We're well past that now, so I'm leaving this here as a historical artefact.
#   export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix)/opt/openssl@1.0"
if exist rbenv; then
	_evalcache rbenv init --no-rehash - zsh;
	() {  # cached rbenv rehash
		rbenvrehashfile="${XDG_CACHE_HOME:-${HOME}/.cache}/last-rbenv-rehash"
		if [ -e "$rbenvrehashfile" ] && test `find "$rbenvrehashfile" -mmin -360`; then 
			:  # don't rehash if less than 6 hrs old
		else
			command rbenv rehash && touch $rbenvrehashfile;
		fi
	}
fi

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
if exist pyenv; then
	_evalcache pyenv init --path --no-rehash - zsh; # ~15 ms, no-rehash saves ~125 ms (pyenv/pyenv#784)
	() {  # cached pyenv rehash
		pyenvrehashfile="${XDG_CACHE_HOME:-${HOME}/.cache}/last-pyenv-rehash"
		if [ -e "$pyenvrehashfile" ] && test `find "$pyenvrehashfile" -mmin -360`; then 
			:  # don't rehash if less than 6 hrs old
		else
			command pyenv rehash && touch $pyenvrehashfile;
		fi
	}
fi
# if exist pyenv-virtualenv-init; then _evalcache pyenv-virtualenv-init -; fi

###-- conda
if exist brew; then
	export CONDA_EXE="$(brew --caskroom)/miniconda/base/bin/conda";
	if [ -x "${CONDA_EXE}" ]; then _evalcache "${CONDA_EXE}" shell.zsh hook; fi;
fi

###-- mamba
# >>> mamba initialize >>>
if exist brew; then
	export MAMBA_EXE="$(brew --prefix)/opt/micromamba/bin/micromamba";
	export MAMBA_ROOT_PREFIX="${HOME}/.micromamba";
	if [ -x "${MAMBA_EXE}" ]; then _evalcache "${MAMBA_EXE}" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX"; fi;
fi

# Don't activate the base environment of conda (let pyenv reign)
# If .condarc already exists, assume the user has set their prefs correctly.
if exist conda && [ ! -f "${HOME}/.condarc" ]; then
	# Only run this if conda is a function, otherwise conda hasn't been imported properly yet
	if (( $+functions[conda] )); then
		conda config --set auto_activate_base false;
	fi
fi

###-- pipenv
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

###-- pipx
export PATH="${HOME}/.local/bin:${PATH}"  # pipx
