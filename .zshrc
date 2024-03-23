# Blake Riley
# .zshrc

# (hattip: https://github.com/spicycode/ze-best-zsh-config)
# (hattip: http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/)

###############################################
###############################################
#############   ZSH environment   #############
###############################################
###############################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#----- zsh modules ---- -----------------------#
autoload -U promptinit && promptinit
# autoload -U compinit && compinit
autoload -U zsh-mime-setup && zsh-mime-setup
autoload -U zcalc

source ${HOME}/.zsh/plugins/evalcache/evalcache.plugin.zsh

source ${HOME}/.zsh/functions.zsh
source ${HOME}/.zsh/zsh-completion.zsh  # NB: this does compinit
if [[ ${TERM_PROGRAM} == "iTerm.app" ]]; then
	source ${HOME}/.zsh/iterm2_shell_integration.zsh
fi
source ${HOME}/.zsh/colors.zsh
source ${HOME}/.zsh/setopt.zsh
source ${HOME}/.zsh/exports.zsh
source ${HOME}/.zsh/editing.zsh
source ${HOME}/.zsh/aliases.zsh
[[ -f ${HOME}/.zsh/servers.zsh ]] && source ${HOME}/.zsh/servers.zsh
source ${HOME}/.zsh/bindkeys.zsh
source ${HOME}/.zsh/history.zsh
source ${HOME}/.zsh/zsh_hooks.zsh
source ${HOME}/.zsh/user_apps.zsh
source ${HOME}/.zsh/prompt.zsh
source ${HOME}/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#--- final commands --- ----------------#
case `uname` in
	Darwin)
		if [[ -v TERM_PROGRAM ]] && [[ ${TERM_PROGRAM} == "vscode" ]]
		then :
		else 
			${HOME}/.zsh/archey-osx/archey.sh --orange --packager --localip
		fi
	;;
esac
