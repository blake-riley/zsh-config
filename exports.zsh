#!/usr/bin/env zsh

#--- zsh
export ZSH=$HOME/.oh-my-zsh
#--- Android
export ANDROID_HOME=/usr/local/opt/android-sdk
#--- Amber
export PATH=/usr/local/amberbin/amber12/bin:$PATH
export AMBERHOME=/usr/local/amberbin/amber12
#--- VMD
export VMDDIR="/Applications/VMD-1.9.2.app/Contents/vmd"

#--- Powerline
export PYTHONPATH=/usr/local/lib/python2.7/site-packages

#-------- PATH -------- -----------------------#
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH


#------ COMPILING ----- -----------------------#
export ARCHFLAGS='-arch x86_64'
