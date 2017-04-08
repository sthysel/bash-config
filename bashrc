# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length 
HISTSIZE=1000
HISTFILESIZE=2000

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y%m%dT%H%M%S%z '
# Append to the history file instead of overwriting.
shopt -s histappend
# Append unsaved commands to history file.
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"


# source all alias and function files in ${ALIAS_HOME} ending in .alias
ALIAS_HOME=${HOME}/bash-config/alias.d 
if [ -d ${ALIAS_HOME} ]
then
  for a in $(find -L ${ALIAS_HOME} -type f -name "*.alias")
  do
    source $a
  done
fi

set -o vi

# Python  virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Autocomplete
if [[ -f /etc/bash_completion ]]
then
  /etc/bash_completion
fi

# ssh-agent 
if ! pgrep -u "$USER" ssh-agent > /dev/null
then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]
then
    eval "$(<~/.ssh-agent-thing)"
fi

# powerline things 
powerline-on() {
  POWERLINE_BASH=/usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
  if [[ -f ${POWERLINE_BASH} ]]
  then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . ${POWERLINE_BASH}
  fi
}
powerline-on


# below is proxy bullshit, creds only live in the air, not in any repo, maybe
# on a post-it on the laptop lid, stick all creds in ~/creds, if the file exist
# load it here
proxy-on() {
    # load proxy config
    PROXY_CONF=${HOME}/.proxy.conf
    if [ -e "${PROXY_CONF}" ]
    then
      source ${PROXY_CONF}
    fi

    export https_proxy=${PROXY}
    export HTTPS_PROXY=${PROXY}

    export http_proxy=${PROXY}
    export HTTP_PROXY=${PROXY}

    export no_proxy=${NO_PROXY}
    export NO_PROXY=${NO_PROXY}
}

if [[ $(hostname) == "devarch" ]]
then
	echo "Proxy is configured"
	proxy-on
fi

proxy-off() {
    unset https_proxy
    unset http_proxy
    unset no_proxy
}

# pass project/repo e.g: wts/breadcrumb
gitclonebhp () {
    URL=https://${BHP_USER}@sdappsgit.ent.bhpbilliton.net/scm
    git clone ${URL}/${1}
}

winmount() {
    sudo mount -t vboxsf meinm9 ./windows/
}


case "${MACHINE_LOCATION}" in
  BHP) proxy-on ;;
  *) ;;
esac

# gitkraken is kraked
alias gitkraken="LD_PRELOAD=/usr/lib/libcurl.so.3 gitkraken"

PATH=$PATH:~/.local/bin/

