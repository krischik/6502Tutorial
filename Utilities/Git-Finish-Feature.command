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

if test ${#} -eq 1; then
    local   in_Task="${1}"
    local Task_Type="${in_Task%%[0-9]*}"
    local   Task_No="${in_Task#${Task_Type}}"

    pushd "${PROJECT_HOME}"
	git status
	git submodule foreach git status

	echo "Task Type   : ${Task_Type}"
	echo "Task Number : ${Task_No}"
	read -sk1 "? add, commit and push (Y/N): "
	echo
#		"Wiki"				\

	if test "${REPLY:u}" = "Y"; then
	    for I in "Documents" ".";  do
		pushd "${I}"
		    echo "### Finishe ${Task_Type} «${Task_No}» for «${I}»"

		    git flow feature finish "${in_Task}"
		    git push
		popd
	    done; unset I
	fi
    popd
else
   echo '
Git-Finish-Feature Task

    Task    Task to finish
'
fi

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
