#!/bin/bash

source install-common.sh

POWERLINE_VERSION=2.2
cd .extern

git clone --branch $POWERLINE_VERSION https://github.com/powerline/powerline
cd powerline
python setup.py build
