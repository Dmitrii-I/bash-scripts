#!/bin/bash

# Bash library containing generic functions

# todo
# function to insert thousand separator into numbers



# Functions

timestamp() {
	date +"%Y-%m-%d %H:%M:%S.%N"
}

is_login_shell() {
	if shopt -q login_shell; then return 0; else return 1; fi
}

is_interactive_shell() {
        [ -z "$PS1" ] && return 1 || return 0
}

closed_files() {
        # pattern should be between double quotes to prevent too early processing of meta-characters like *
        dir=${1:-.}
        pattern=${2:-*}
        all_files=$(find $dir -maxdepth 1 -type f -name "$pattern")

        # If there are no matched files, exit successfully, otherwise proceed
        [ -z "$all_files" ] && return 0 || all_files=$(echo "$all_files" | xargs -L1 basename)
        for file in $all_files; do
                num_file_handles=$(lsof -f -- $dir/$file | wc -l)
		if [ $num_file_handles -lt 1 ]; then echo $file; fi
        done
}

download_files() {
        while read -t 3 line; do
                scp -C "$line" .
        done
}


append()
{
        postfix="$1"
        while read -t 3 line; do
                echo "$line$postfix"
        done
}

prepend() {
        prefix="$1"
        while read -t 3 line; do
                echo "${prefix}${line}"
        done
}

s() {
        # This function sources this script
        source ~/bash-scripts/lib-bash-generic.sh
}

write_log() 
{
        # This function reads global variables $LOG, $SCRIPT_NAME,
        # and $@ (all the arguments passed to it). It then 
        # constructs a tab-delimited one-line message and appends
        # it to $LOG.
        ts=$(timestamp)
        logmsg="$ts\tINFO\t$SCRIPT_NAME\t$@\n"
        echo -ne "$logmsg" >> $LOG
}
