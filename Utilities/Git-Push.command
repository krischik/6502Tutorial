#!/opt/local/bin/zsh
############################################################# {{{1 ##########
#  Copyright © 2019 … 2020 Martin Krischik «krischik@users.sourceforge.net»
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
#
# Push current branch, develop and master:
#
# ⑴ stash changes
# ⑵ merge server version of develop with local develop and push
# ⑶ merge server version of master with local master push
# ⑷ unstash changes
#
# This is needed to merge develop into your feature branch to avoid merger
# confict within the pull requests.
#

setopt Err_Exit
setopt No_XTrace

local Current_Branch=$(git branch | grep "*" | cut -d ' ' -f2)

git stash push
git fetch --all
git fetch --prune
git fetch --tags

git checkout    "master"
git merge       "FETCH_HEAD"
git push 

git checkout    "develop"
git merge       "FETCH_HEAD"
git push 

git checkout    "${Current_Branch}"
git push --all
git stash pop

git push --tags

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
