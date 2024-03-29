# Awesome WM configuration

## About

This repository stores my configuration of [Awesome WM][awesome], *a highly
configurable, next generation framework window manager for X*.

## Getting the files

### Using Git

If we have Git installed on the system, we can get the files directly from the
repository.

For Git version 1.6.5 or later:

    git clone --recursive https://gitlab.com/aguslr/awesome-config

For older versions:

    git clone https://gitlab.com/aguslr/awesome-config && cd awesome-config && git submodule init && git submodule update

After this, every time we want to update the files we do:

    cd awesome-config && git pull

To pull changes for each submodule, we can run the following command (Git
version 1.6.1 and above):

    cd awesome-config && git submodule foreach git pull

### Without Git

If Git is not installed, we can still get the files as long as we have a basic
Unix environment available:

    wget https://gitlab.com/aguslr/awesome-config/-/archive/main/awesome-config-main.tar.gz -O - | tar -xzv --strip-components 1 --exclude={README.md,demo.gif}

## Installing with Stow

To easily create and manage links to the files we can use [GNU Stow][stow] as
follows:

    stow -vt ~ -S .

## Demo

![Demo GIF](https://gitlab.com/aguslr/awesome-config/raw/main/demo.gif "Demo")

[awesome]: https://awesomewm.org/
[stow]:  https://www.gnu.org/software/stow/
