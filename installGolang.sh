#!/bin/bash

echo "Installing Golang..."

SOURCE_DIR="/Sources/go"
DEFAULT_SOURCE_DIR="$HOME$SOURCE_DIR"
DEFAULT_SHELL_PROFILE="$HOME/.zprofile"
DEFAULT_GVM_CONFIG_DIR="$HOME/.gvm"

if [ -d "$DEFAULT_SOURCE_DIR" ]; then
	echo "$DEFAULT_SOURCE_DIR exist"
else 
	mkdir $DEFAULT_SOURCE_DIR
fi

if [ -f "$DEFAULT_SHELL_PROFILE" ]; then 
	echo "$DEFAULT_SHELL_PROFILE exis"
	else
		touch $DEFAULT_SHELL_PROFILE
fi

while getopts d:s: flag
do case "${flag}" in
	d) DEFAULT_SOURCE_DIR=${OPTARG};;
	s) DEFAULT_SHELL_PROFILE=$HOME${OPTARG};;
esac
done

echo "-- Source dir - $DEFAULT_SOURCE_DIR"
echo "-- Shell profile - $DEFAULT_SHELL_PROFILE"
echo "-- GVM config dir - $DEFAULT_GVM_CONFIG_DIR"

echo ""

echo "Installing gvm..."

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

source $HOME/.gvm/scripts/gvm

GO_LAST_VERSION=$(gvm listall | grep -v "beta" | grep -v "rc" | grep go1. | tail -1)

gvm install $GO_LAST_VERSION &&
gvm use $GO_LAST_VERSION --default

echo "Setting GOPATH to shell profile"
echo 'export GOPATH=$GOPATH:$(find $HOME/Sources/Go -maxdepth 1 -type d -print0 | xargs -0 | tr -s " " ":")' >> $DEFAULT_SHELL_PROFILE

echo '[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"' >> $DEFAULT_SHELL_PROFILE


