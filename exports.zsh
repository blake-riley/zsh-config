#!/usr/bin/env zsh

#--- zsh
export ZSH=$HOME/.oh-my-zsh
#--- Android
export ANDROID_HOME=/usr/local/opt/android-sdk
#--- Amber
export AMBERHOME=/sw/amber14
export PATH=$AMBERHOME/bin:$PATH

#--- VMD
export VMDDIR="/Applications/VMD-1.9.2.app/Contents/vmd"

#--- Powerline
export PY_PKGS=/usr/local/lib/python3.6/site-packages

#--- Homebrew/Cask
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

#-------- PATH -------- -----------------------#
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$PATH:`dirname '/Applications/APBS.app/Contents/MacOS/apbs_term'`


#------ COMPILING ----- -----------------------#
export ARCHFLAGS='-arch x86_64'
