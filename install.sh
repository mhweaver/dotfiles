#!/bin/bash

POWERLINE_VERSION=2.2

if [ -e .extern ]; then
	rm -rf .extern
fi
mkdir .extern
cd .extern

git clone --branch $POWERLINE_VERSION https://github.com/powerline/powerline
cd powerline
python setup.py build

