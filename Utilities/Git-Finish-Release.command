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
    local in_Release="${1}"
    local in_Comment="${2}"

    pushd "${PROJECT_HOME}"
	git status
	git submodule foreach git status

	echo "Release     : ${in_Release}"
	echo "Comment     : ${in_Comment}"
	read -sk1 "? add, commit, publish and finish (Y/N): "
	echo

	if test "${REPLY:u}" = "Y"; then
	    for I in "." "Documents";  do
		pushd "${I}"
		    echo "### Publish ${in_Release} for «${I}»"

		    git add "."
		    if ! git commit -m"${in_Release} : ${in_Comment}"; then
			echo "nothing to commit but we publish anyway"
		    fi

		    if ! git flow release publish "${in_Release}"; then
			echo "publish failed, try a simple push instead"
			git push
		    fi

		    git flow release finish "${in_Release}"

		    git push --tags
		    git checkout master
		    git push
		    git checkout develop
		    git push
		popd
	    done; unset I
	fi
    popd
else
   echo '
Git-Publish-Release Task Comment

    Task    Task to publish
    Comment Comment for publish
'
fi

############################################################## {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
