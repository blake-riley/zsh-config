#!/usr/bin/env zsh

# Gets the *default* ip address only.
function default_ip
{
  /usr/bin/ruby -e '
  require "socket"

  Socket.do_not_reverse_lookup = true

  UDPSocket.open { |s| s.connect("64.233.187.99", 1); puts s.addr.last }
  '
}

# Detect the packager.
if [ -x /usr/local/bin/brew ]; then
  packager=homebrew
elif command -v port >/dev/null; then
  packager=macports
else
  packager=none
fi

# Get the command line options
opt_nocolor=f
opt_force_color=f
opt_orange_color=f
for arg in "$@"
do
  case "${arg}" in
    -m|--macports)
      packager=macports
      ;;
    -b|--nocolor)
      opt_nocolor=t
      ;;
    -c|--color)
      opt_nocolor=f
      opt_force_color=t
      ;;
    --orange)
      opt_nocolor=f
      opt_force_color=t
      opt_orange_color=t
      ;;
    -h|--help)
      echo "Usage: $0 [options]"
      echo
      echo "  -m --macports Use MacPorts as package system (default packager: ${packager})."
      echo "  -b --nocolor  Turn color off."
      echo "  -c --color    Force the color on (overrides --nocolor)."
      echo "     --orange   Make the apple logo appear orange (overrides --nocolor)."
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" 1>&2
      echo "For help, use: $0 --help" 1>&2
      exit 1
      ;;
  esac
done

# System Variables
user=$(whoami)
hostname=$(hostname | sed 's/.local//g')
ip=$(default_ip)
distro="OS X $(sw_vers -productVersion)"
kernel=$(uname)
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
shell=$(dscl . -read /Users/$user UserShell | awk '{print $2}')
terminal="$TERM"
cpu=$(sysctl -n machdep.cpu.brand_string)

# removes (R) and (TM) from the CPU name so it fits in a standard 80 window
cpu=$(echo "$cpu" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')

ram="$(( $(sysctl -n hw.memsize) / 1024 ** 3  )) GB"
disk=$(df | head -2 | tail -1 | awk '{print $5}')


# Set up colors if:
# * stdout is a tty
# * the user hasn't turned it off
# * or if we're forcing color
if [[ ( -t 1  && "${opt_nocolor}" = f) || "${opt_force_color}" = t ]]
then
  if [[ "${opt_orange_color}" = t ]]
  then
    RED=$(tput       setaf 166 2>/dev/null)
    GREEN=$(tput     setaf 166 2>/dev/null)
    YELLOW=$(tput    setaf 166 2>/dev/null)
    BLUE=$(tput      setaf 166 2>/dev/null)
    PURPLE=$(tput    setaf 166 2>/dev/null)
    textColor=$(tput setaf 6 2>/dev/null)
    normal=$(tput    sgr0 2>/dev/null)
  else
    RED=$(tput       setaf 1 2>/dev/null)
    GREEN=$(tput     setaf 2 2>/dev/null)
    YELLOW=$(tput    setaf 3 2>/dev/null)
    BLUE=$(tput      setaf 4 2>/dev/null)
    PURPLE=$(tput    setaf 5 2>/dev/null)
    textColor=$(tput setaf 6 2>/dev/null)
    normal=$(tput    sgr0 2>/dev/null)
  fi
fi

case "${packager}" in
  homebrew)
    packagehandler=$(brew list -l | wc -l | awk '{print $1 }')
    ;;
  macports)
    packagehandler=$(port installed | wc -l | awk '{print $1 }')
    ;;
  *)
    packagehandler=0
    ;;
esac

userText="${textColor}User:${normal}"
hostnameText="${textColor}Hostname:${normal}"
distroText="${textColor}Distro:${normal}"
kernelText="${textColor}Kernel:${normal}"
uptimeText="${textColor}Uptime:${normal}"
ipText="${textColor}IP Address:${normal}"
shellText="${textColor}Shell:${normal}"
terminalText="${textColor}Terminal:${normal}"
packagehandlerText="${textColor}Packages:${normal}"
cpuText="${textColor}CPU:${normal}"
memoryText="${textColor}Memory:${normal}"
diskText="${textColor}Disk:${normal}"

# The ${foo#  } is a cheat so that it lines up here as well
# as when run.
echo -e "

${GREEN#  }                 ###
${GREEN#  }               ####                   $userText $user
${GREEN#  }               ###                    $hostnameText $hostname
${GREEN#  }       #######    #######             $ipText $ip
${YELLOW# }     ######################           $distroText $distro
${YELLOW# }    #####################             $kernelText $kernel
${RED#    }    ####################              $uptimeText $uptime
${RED#    }    ####################              $shellText $shell
${RED#    }    #####################             $terminalText $terminal
${PURPLE# }     ######################           $packagehandlerText $packagehandler
${PURPLE# }      ####################            $cpuText $cpu
${BLUE#   }        ################              $memoryText $ram
${BLUE#   }         ####     #####               $diskText $disk${normal}

"