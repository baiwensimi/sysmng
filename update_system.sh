#!/usr/bin/env bash

echo "升级系统!"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# ...
	echo "this is linux"
	# If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
	if [[ "$DISTRO" == "Ubuntu" ]]; then
		sudo apt update
		sudo apt upgrade
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo "update this Mac OSX"
	brew upgrade
	brew cleanup
    zsh -ic "omz update"
elif [[ "$OSTYPE" == "cygwin" ]]; then
	# POSIX compatibility layer and Linux environment emulation for Windows
	echo "cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
	# Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
	echo "mingw"
elif [[ "$OSTYPE" == "win32" ]]; then
	# I'm not sure this can happen.
	echo "win32?"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	# ...
	echo "freebsd"
else
	# Unknown.
	echo "unknow!!!!!"
fi

## update conda.

echo "update conda enviorment"

env_lst=`conda env list|grep -v ^#|awk '{print $1}'`
for env in $env_lst
do
	echo "# begin to update enviorment $env"
	conda update -y --all -n $env
done
