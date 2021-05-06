#!/usr/bin/env zsh

#--- brew
# export HOMEBREW_BUILD_FROM_SOURCE=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
#--- Android
export ANDROID_HOME="/usr/local/opt/android-sdk"
#--- Amber
export AMBERHOME="/sw/amber18"
export AMBER_PREFIX="/sw/amber18"
#--- VMD
if [[ $(uname -s) == Darwin ]]; then
	export VMDDIR="/Applications/VMD-1.9.4.app/Contents/vmd"
fi

#--- Python
export PYENV_ROOT="${HOME}/.pyenv"
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

#--- Ruby
if [[ $(uname -s) == Darwin ]] && $(command -v brew 1>/dev/null 2>&1); then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

#--- Perl
#export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
#export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
#export PERL_MB_OPT="--install_base \"${HOME}/perl5\""
#export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"

#-------- PATH -------- -----------------------#
export PATH="${HOME}/.iterm2/bin:${PATH}"  # iterm2_shell_integrations
export PATH="${AMBERHOME}/bin:${PATH}"  # Amber
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${PYENV_ROOT}/bin:${PATH}"  # pyenv
#export PATH="${HOME}/.cabal/bin:${PATH}"  # Haskell
export PATH="${HOME}/.cargo/bin:${PATH}"  # rustup
export PATH="${HOME}/perl5/bin${PATH+:}${PATH}"  # Perl
export PATH="${PATH}:$(dirname '/Applications/APBS.app/Contents/MacOS/apbs_term')"
export PATH="${PATH}:/opt/xds/bin"  # XDS

#------ COMPILING ----- -----------------------#
export ARCHFLAGS='-arch x86_64'
