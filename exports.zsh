#!/usr/bin/env zsh

#--- zsh
export ZSH="${HOME}/.oh-my-zsh"
#--- brew
# export HOMEBREW_BUILD_FROM_SOURCE=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
#--- Android
export ANDROID_HOME="/usr/local/opt/android-sdk"
#--- Amber
export AMBERHOME="/sw/amber14"

#--- VMD
export VMDDIR="/Applications/VMD-1.9.4.app/Contents/vmd"

#--- Perl
#export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
#export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
#export PERL_MB_OPT="--install_base \"${HOME}/perl5\""
#export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"

#-------- PATH -------- -----------------------#
export PATH="${AMBERHOME}/bin:${PATH}"  # Amber
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
#export PATH="${HOME}/.cabal/bin:${PATH}"  # Haskell
export PATH="${HOME}/.cargo/bin:${PATH}"  # rustup
export PATH="${HOME}/perl5/bin${PATH+:}${PATH}"  # Perl
export PATH="${PATH}:$(dirname '/Applications/APBS.app/Contents/MacOS/apbs_term')"


#------ COMPILING ----- -----------------------#
export ARCHFLAGS='-arch x86_64'
