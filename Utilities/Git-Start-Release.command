#!/opt/local/bin/zsh
############################################################## {{{1 ##########
#  Copyright © 2015 … 2019 KPT/CPT
#  Author Martin Krischik «krischik.martin@kpt.ch»
############################################################## }}}1 ##########

setopt Err_Exit
setopt No_XTrace

if test ${#} -eq 1; then
    local in_Branch="${1}"

    pushd "${PROJECT_HOME}"
        for I in "." "Documents"; do
            if test -e "${I}"; then
                pushd "${I}"
                    echo "### Betrete [42;37;1m«${I}»[m"

                    echo "### Pull    [44;37;1m«develop»[m"
                    git checkout "develop"
                    git pull

                    echo "### Branch  [44;37;1m«${in_Branch}»[m for [44;37;1m«${I}»[m"
                    git flow release start "${in_Branch}"
                popd
            fi
        done; unset I
    popd
else
   echo '
Git-Start-Release Branch

    Branch Release to start
'
fi

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
