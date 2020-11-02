#!/usr/local/bin/zsh
############################################################## {{{1 ##########
#   $Author: krischik@macports.org $
#   $Revision: 133186 $
#   $Date: 2015-02-23 14:59:43 +0100 (Mo, 23. Feb 2015) $
#   $HeadURL: http://svn.macports.org/repository/macports/users/krischik/Utilities/Update.command $
############################################################## }}}1 ##########

setopt No_XTrace
setopt No_Err_Exit
setopt Multi_OS

echo Run «${0:a}» as user «${USER}»

if test "${USER}" = "root"; then
    # brew root confugurations
    #

    # do nothign for now
else
    echo "===> Brew Update"

    brew update
    brew upgrade
    brew cleanup

    echo "Login to «root»"
    sudo ${0:a}
fi

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
