#!/bin/zsh
############################################################## {{{1 ##########
#  Copyright © 2015 … 2019 KPT/CPT
############################################################## }}}1 ##########

if test -z "${PROJECT_HOME}"; then
    source "${0:h}/Setup.command"
fi

setopt Err_Exit
setopt No_XTrace
setopt Multi_OS

if test "${USER}" = "root"; then
    # brew root confugurations
    #

    # do nothign for now
else
    setopt Multi_OS

    brew update
    brew upgrade

    # tab brews
    #
    brew tap microsoft/git

    # install brews
    #
    brew install		\
	arduino-cli		\
	cc65			\
	coreutils		\
	ctags			\
	git			\
	git-credential-manager	\
	git-flow		\
	libusb			\
	minipro			\
	pkg-config		\
	zsh			\
	zsh-completions

    # install brews with GUI
    #
    brew cask install		\
	macvim			\
	macdown

    # configure brews
    #
    brew link macvim
    brew link libusb

    echo "Login to «root»"
    sudo ${0:a}
fi

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
