#!/bin/bash

# STRICT MODE
# FIXME: set -u breaks the script because of $1 variables
set -eo pipefail
IFS=$'\n\t'

# CONFIG
editor=nvim
path=$HOME/todo
date=$(date "+%y-%m-%d/%a")

if [[ ! -e $path ]]; then
	echo "Can not find the todo file in '$path'"
	exit 1
fi

if [[ $# > 1 ]]; then
	echo "Too many arguments. Only one todo at a time."
	exit 1
elif [[ $1 ]]; then
	if [[ $1 == 'e' ]]; then
		$editor $HOME/todo
	elif [[ $1 == 'help' || $1 == '--help' || $1 == '-h' || $1 == 'h' ]]; then
    echo "td - to list all todos"
		echo "td \"Hi, mom!\" - to create a todo"
    echo "td e - to open the todo file in $editor"
	else
    sed -i "1i [ ] $1 [$date]" $path
	fi
else cat $path
fi
