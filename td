#!/bin/bash

# STRICT MODE
set -eou pipefail
IFS=$'\n\t'

# CONFIG
editor=nvim
path=$HOME/todo
date=$(date "+%y-%m-%d/%a")

if [[ ! -e $path ]]; then
	echo "Can not find the todo file in '$path'"
	exit 1
fi

if [[ $# > 0 ]]; then
	if [[ $1 == 'e' ]]; then
		$editor $HOME/todo
	elif [[ $1 == 'help' || $1 == '--help' || $1 == '-h' || $1 == 'h' ]]; then
		echo "td - to list the first 10 todos"
		echo "td \"Hi, mom!\" \"Do the dishes\" - to create a todo or multiple todos"
		echo "td e - to open the todo file in $editor"
	else
		for arg in $@ 
		do
			sed -i "1i \ ] $arg [$date]" $path
		done
	fi
else head $path
fi
