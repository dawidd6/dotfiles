#!/bin/sh

if [ -f /run/.containerenv ] || [ -f /.dockerenv ]; then
    echo "Copying dotfiles..."
    cp -R ~/dotfiles/. ~/
else
    echo "Not in a container! Exiting..."
    exit 127
fi

