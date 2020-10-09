# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


## Shell Options

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell


## Completion Options

# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Git completion
git_comp="$HOME/.git-completion.bash"
if [ ! -f $git_comp ]; then
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $git_comp
fi
source $git_comp


## History Options

# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Set date and time format for history comamnd
# See https://zwischenzugs.com/2019/05/11/seven-surprising-bash-variables/
HISTTIMEFORMAT='+%F %T%z '

HISTSIZE=30000
HISTFILESIZE=30000


# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


## Aliases

# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Show a prompt before about to overwrite an existing file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Colorize by ANSI color escape sequences
alias less='less --RAW-CONTROL-CHARS'

# where, of a sort
alias whence='type -a'

alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias gst='git status'
alias gdi='git diff'

# Colorize ls command output
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G"
    ;;
  *)
    alias ls='ls --color=auto'
    ;;
esac

alias ll='ls -Alh'
alias la='ls -A'

# Colorize diff command output
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff'
elif diff --help | grep color > /dev/null; then
  alias diff='diff --color'
else
  :
fi

# Convert character encoding
case "${OSTYPE}" in
  darwin*)
    ;;
  *)
    type cocot > /dev/null 2>&1
    if [ $? -eq 0 ]; then
      alias ping='cocot ping'
    fi
    ;;
esac

# Set up open command for Cygwin
case "${OSTYPE}" in
  CYGWIN*)
    alias open='cygstart'
    ;;
esac

# Display weather
alias weather='curl -4 wttr.in/?M'
# Able to specify a city like: alias weather='curl -4 wttr.in/Tokyo?M'

# Interactive Perl Shell (REPL for Perl)
alias ipl='perl -de 1'

alias n='sudo n'

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func

function g() {
  cd $(ghq root)/$(ghq list | peco)
}

function git-push-with-tags() {
  git push
  git push --tags
}

function git-clean-after-merging-PR() {
  if [ "$1" == "" ]; then
    currentBranch=$(git branch --show-current)
    read -p "Enter target branch name [${currentBranch}]: " answer
    targetBranch=${answer:-$currentBranch}
  fi
  git checkout master && git pull && git branch -d "$targetBranch" && git pull --prune
}

# Set a default prompt of: user@host ~/path $
PS1='\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] \$ '

