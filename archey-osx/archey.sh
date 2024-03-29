#!/usr/bin/env bash

# archey-osx 1.6.1-orange (https://github.com/obihann/archey-osx/)

# test to see if bash supports arrays
arraytest[0]='test' || (echo 'Error: Arrays are not supported in this version of
bash.' && exit 2)

# Detect the packager.
if command -v brew 1>/dev/null 2>&1; then
  detectedpackager=homebrew
elif command -v port 1>/dev/null 2>&1; then
  detectedpackager=macports
else
  detectedpackager=none
fi

# Get the command line options
opt_nocolor=f
opt_force_color=f
opt_orange_color=f
opt_offline=f
for arg in "$@"
do
  case "${arg}" in
    -p|--packager)
      packager=$detectedpackager
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
    -o|--offline)
      opt_offline=t
      ;;
    -l|--localip)
		  opt_localip=t
      ;;
    -h|--help)
      echo "Archey OS X 1.6.1"
      echo
      echo "Usage: $0 [options]"
      echo
      echo "  -p --packager  Use auto detected package system (default packager: ${detectedpackager})."
      echo "  -b --nocolor   Turn color off."
      echo "  -c --color     Force the color on (overrides --nocolor)."
      echo "     --orange   Make the apple logo appear orange (overrides --nocolor)."
      echo "  -o --offline   Disable the IP address check."
      echo "  -l --localip   Show local IP adddress"
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

# v4 and v6 address detection
if [[ "${opt_offline}" = f ]]; then
    ipfile4="${XDG_CACHE_HOME:-${HOME}/.cache}/archey-ipv4"
    ipfile6="${XDG_CACHE_HOME:-${HOME}/.cache}/archey-ipv6"
    if [ -a "$ipfile4" ] && test `find "$ipfile4" -mmin -360`; then
        while read -r line; do
            V4="$line"
        done < "$ipfile4"
    else
        if V4=$(dig +time=5 +tries=1 +short myip.opendns.com A @resolver1.opendns.com 2>/dev/null); then
            echo $V4 > "$ipfile4"
        fi
    fi
    if [ -a "$ipfile6" ] && test `find "$ipfile6" -mmin -360`; then
        while read -r line; do
            V6="$line"
        done < "$ipfile6"
    else
        if V6=$(dig +time=5 +tries=1 +short myip.opendns.com AAAA @resolver1.opendns.com 2>|/dev/null); then
            echo $V6 > "$ipfile6"
        fi
    fi
fi

if [[ "${opt_localip}" = t ]]; then
	# Get the interface used for the default route
	activeadapter=$(route -n get 0.0.0.0 | awk '/interface: / {print $2}')
	# Now get the IP address assigned to that interface
	localip=$(ifconfig ${activeadapter} | awk '/inet / {print $2}')
fi

distro="$(sw_vers -productName) $(sw_vers -productVersion)"
kernel=$(uname)
uptime=$(uptime 2> /dev/null | sed -e 's/.*up[[:space:]]*//' -e 's/,[[:space:]]*[0-9]* user.*//')
shell="$SHELL"
terminal="$TERM ${TERM_PROGRAM//_/ }"
cpu=$(sysctl -n machdep.cpu.brand_string)
battery=$(ioreg -c AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f%"; max=c["\"MaxCapacity\""]; if (max>0) { print 100*c["\"CurrentCapacity\""]/max;} }')

# removes (R) and (TM) from the CPU name so it fits in a standard 80 window
cpu=$(echo "$cpu" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')

ram="$(( $(sysctl -n hw.memsize) / 1024 ** 3  )) GB"
disk="$(df -h | grep '/Volumes/Data$' | awk '{print $5 ", " $4 " avail"}')"


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
  else
    RED=$(tput       setaf 1 2>/dev/null)
    GREEN=$(tput     setaf 2 2>/dev/null)
    YELLOW=$(tput    setaf 3 2>/dev/null)
    BLUE=$(tput      setaf 4 2>/dev/null)
    PURPLE=$(tput    setaf 5 2>/dev/null)
  fi
  textColor=$(tput setaf 6 2>/dev/null)
  normal=$(tput    sgr0 2>/dev/null)
fi

npackagesfile="${XDG_CACHE_HOME:-${HOME}/.cache}/archey-npackages"
if [ -a "$npackagesfile" ] && test `find "$npackagesfile" -mmin -360`; then
    while read -r line; do
        packagehandler="$line"
    done < "$npackagesfile"
else
  case "${packager}" in
    homebrew)
      if packagehandler=$(brew list --formula -1 | wc -l | awk '{print $1 }' 2>/dev/null); then
          echo $packagehandler > "$npackagesfile"
      fi
      ;;
    macports)
      if packagehandler=$(port installed | wc -l | awk '{print $1 }' 2>/dev/null); then
          echo $packagehandler > "$npackagesfile"
      fi
      ;;
    *)
      packagehandler=0
      ;;
  esac
fi

fieldlist[${#fieldlist[@]}]="${textColor}User:    ${normal} ${user}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Hostname:${normal} ${hostname}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Distro:  ${normal} ${distro} | ${kernel}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Uptime:  ${normal} ${uptime}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Shell:   ${normal} ${shell}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Terminal:${normal} ${terminal}${normal}"
if [ ${packagehandler} -ne 0 ]; then
    fieldlist[${#fieldlist[@]}]="${textColor}Packages:${normal} ${packagehandler}${normal}"
fi
fieldlist[${#fieldlist[@]}]="${textColor}CPU:     ${normal} ${cpu}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Memory:  ${normal} ${ram}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Disk:    ${normal} ${disk}${normal}"
if [[ ! -z $battery ]]; then
    fieldlist[${#fieldlist[@]}]="${textColor}Battery: ${normal} ${battery}%${normal}"
fi
# Texts had to be shortend to fit in 80 window
if [ "${opt_offline}" = f ]; then
    if [ ! -z "$V4" ]; then
      fieldlist[${#fieldlist[@]}]="${textColor}IPv4:    ${normal} ${V4}${normal}"
    fi
    if [ ! -z "$V6" ]; then
      fieldlist[${#fieldlist[@]}]="${textColor}IPv6:    ${normal} ${V6}${normal}"
    fi
fi
if [ "${opt_localip}" = t ]; then
	fieldlist[${#fieldlist[@]}]="${textColor}Local IP:${normal} ${localip}${normal}"
fi

logofile=${ARCHEY_LOGO_FILE:-"${HOME}/.config/archey-logo"}
if [ -a "$logofile" ]
  then
  source "$logofile"
else
# The ${foo#  } is a cheat so that it lines up here as well
# as when run.
  echo -e "
${GREEN#  }                 ###               ${fieldlist[0]}
${GREEN#  }               ####                ${fieldlist[1]}
${GREEN#  }               ###                 ${fieldlist[2]}
${GREEN#  }       #######    #######          ${fieldlist[3]}
${YELLOW# }     ######################        ${fieldlist[4]}
${YELLOW# }    #####################          ${fieldlist[5]}
${RED#    }    ####################           ${fieldlist[6]}
${RED#    }    ####################           ${fieldlist[7]}
${RED#    }    #####################          ${fieldlist[8]}
${PURPLE# }     ######################        ${fieldlist[9]}
${PURPLE# }      ####################         ${fieldlist[10]}
${BLUE#   }        ################           ${fieldlist[11]}
${BLUE#   }         ####     #####            ${fieldlist[12]}
${normal}
"
fi
