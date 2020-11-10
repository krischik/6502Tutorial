#!/opt/local/bin/zsh
############################################################# {{{1 ##########
#  Copyright © 2019 Martin Krischik «krischik@users.sourceforge.net»
#############################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or ENDIFFTNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see «http://www.gnu.org/licenses/».
############################################################# }}}1 ##########

if test -z "${PROJECT_HOME}"; then
    source "${0:h}/Setup.command"
fi

setopt Err_Exit
setopt No_XTrace

pushd "${PROJECT_HOME}"
    if ! test -d "Temp"; then
        mkdir "Temp"
    fi

    pushd "Temp"
        wget "http://www.xgecu.com/MiniPro/xgproV1041_setup.rar"
        7z x "xgproV1041_setup.rar"
        7z x "XgproV1041_Setup.exe"

        if ! minipro --update "updateII.dat"; then
        echo "
if you got a “Switching to bootloader... failed!”
then the first step to fix it is: Try again using
the following command:

cd "${PROJECT_HOME}/Temp"
minipro --update "updateII.dat"

It seems that the sometime minipro fails to 
detect the swich to bootloader on the first
attempt.
"
        else
            echo "
Consider deleting the temp directory with

rm -r "${PROJECT_HOME}/Temp"

All script needed it will recreate it.
"
        fi
    popd

ec

popd

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
