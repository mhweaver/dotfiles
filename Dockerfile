FROM ubuntu:bionic

WORKDIR /root

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    make \
    software-properties-common \
    stow \
    vim \
    zsh && \
  apt-add-repository -y ppa:neovim-ppa/stable && \
  apt-get update -qq && \
  apt-get install -y neovim

COPY . ./dotfiles