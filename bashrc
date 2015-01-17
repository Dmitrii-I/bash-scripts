# .bashrc is loaded for interactive and non-interactive shell (unless you prevent it)
# .bash_profile is loaded for login shells
# we use .bashrc only to ensure that a file is always loaded no matter the shell type

PATH=$PATH:/usr/sbin:$HOME/.local/bin:$HOME/bin
export PATH

source ~/bash-scripts/lib-bash-generic.sh



# interactive shells only:

if is_interactive_shell; then 
        # this allows you to cycle through autocompletion instead of typing
        bind TAB:menu-complete 
fi


# set custom bash prompt
export PS1="\[\e[00;35m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;35m\]\H\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]\\$ \[\e[0m\]"


alias ll='ls -lh --color=auto'



export TERM=xterm-256color
eval `dircolors ~/dircolors-solarized/dircolors.ansi-dark`


# easier grepping through processes
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; } 



# do not store consecutive duplicates
export HISTCONTROL=ignoredups
# keep only unique commands:
#export HISTCONTROL=erasedups
# number of lines to save for a session
export HISTSIZE=9999
# number of most recent lines to keep in history file (default: .bash_hsitory)
export HISTFILESIZE=999999
# keep history in sync accross all sessions:
#export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
