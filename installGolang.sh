#!/bin/bash

echo "Installing Golang..."

echo "Install gvm"

export GOPATH=$GOPATH$(find $HOME/Sources/go -maxdepth 1 -type d -print0 | xargs -0 | tr -s ' ' ':')

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

LAST_GO_VERSION=$(gvm listall | grep go1. | tail -1)

echo "Install $(LAST_GO_VERSION)"

gvm install $(LAST_GO_VERSION)

echo "Set default version"

gvm use $(LAST_GO_VERSION) --default)
