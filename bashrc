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

# virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh


# powerline things 
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

POWERLINE_BASH=/usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
. ${POWERLINE_BASH}


# sshagent
SSHAGENT=/usr/bin/ssh-agent                                                                                        
SSHAGENTARGS="-s"
if [ -z "${SSH_AUTH_SOCK}" -a -x "SSHAGENT" ]
then
    eval `$SSHAGENT ${SSHAGENTARGS}`
    trap "kill ${SSH_AGENT_PID}" 0
fi

# below is proxy bullshit, creds only live in the air, not in any repo, maybe
# on a post-it on the laptop lid, stick all creds in ~/creds, if the file exist
# load it here

# load creds
CREDS=${HOME}/creds
if [ -e "${CREDS}" ]
then
    source ${CREDS}
fi

export PROXY=http://${BHP_USER}:${BHP_PASSWORD}@10.17.236.44:8080
export NO_PROXY=localhost,.bhpbilliton.net,wtstool

proxy-on() {
    export https_proxy=${PROXY}
    export HTTPS_PROXY=${PROXY}

    export http_proxy=${PROXY}
    export HTTP_PROXY=${PROXY}

    export no_proxy=${NO_PROXY}
    export NO_PROXY=${NO_PROXY}
}

proxy-off() {
    unset https_proxy
    unset http_proxy
    unset no_proxy
}

# pass project/repo e.g: wts/breadcrumb
gitclonebhp () {
    URL=https://meinm9@sdappsgit.ent.bhpbilliton.net/scm
    git clone ${URL}/${1}
}

