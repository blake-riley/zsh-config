# Blake Riley
# .zshrc

# (hattip: https://github.com/spicycode/ze-best-zsh-config)
# (hattip: http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/)

###############################################
###############################################
#############   ZSH environment   #############
###############################################
###############################################

#----- zsh modules ---- -----------------------#
autoload -U promptinit && promptinit
autoload -U compinit && compinit
autoload -U zsh-mime-setup && zsh-mime-setup
autoload -U zcalc

source $HOME/.zsh/iterm2_shell_integration.zsh
source $HOME/.zsh/colors.zsh
source $HOME/.zsh/setopt.zsh
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/editing.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/servers.zsh
#source $HOME/.zsh/bindkeys.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/zsh_hooks.zsh
source $HOME/.zsh/source_apps.zsh
source $HOME/.zsh/prompt.zsh

#--- final commands --- ----------------#
$HOME/.zsh/archey-osx/archey.sh --orange --packager --localip
