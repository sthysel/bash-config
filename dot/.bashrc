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
ALIAS_HOME=${HOME}/.config/bash/alias.d 
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
VIRTENV_WRAPPER=/usr/bin/virtualenvwrapper.sh
if [ -f $VIRTENV_WRAPPER ]
then
    source $VIRTENV_WRAPPER 
fi

# Autocomplete
BASH_COMPLETION=/etc/bash_completion 
if [[ -f $BASH_COMPLETION ]]
then
    source $BASH_COMPLETION
fi

# ssh-agent 
ssh-agent-on() {
  if ! pgrep -u "$USER" ssh-agent > /dev/null
  then
      ssh-agent > ~/.ssh-agent-thing
  fi
  if [[ "$SSH_AGENT_PID" == "" ]]
  then
      eval "$(<~/.ssh-agent-thing)"
  fi
}
#ssh-agent-on

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

PATH=$PATH:~/.local/bin/

