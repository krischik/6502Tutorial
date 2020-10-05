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

if test ${#} -eq 2; then
    local in_Task="${1}"
    local in_Comment="${2}"

    local Task_Type="${in_Task%%[0-9]*}"
    local   Task_No="${in_Task#${Task_Type}}"

    pushd "${PROJECT_HOME}"
	git status
	git submodule foreach git status

	echo "Task Type   : ${Task_Type}"
	echo "Task Number : ${Task_No}"
	echo "Comment     : ${in_Comment}"
	read -sk1 "? add, commit and publish (Y/N): "
	echo

	if test "${REPLY:u}" = "Y"; then
	    for I in "Documents" ".";  do
		pushd "${I}"
git checkout develop
git merge feature/Enhancement22
git commit -m"Enhancement #22 Make amount, price and reward_fund hive compatible."
git flow release start  'Enhancement22.2'
git flow release finish 'Enhancement22.2'
git push --tags origin
git push origin master
git push origin develop
git checkout feature/Enhancement22
		popd
	    done; unset I
	fi
    popd
else
   echo '
Git-Publish-Feature Task Comment

    Task    Task to publish
    Comment Comment for publish
'
fi

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
