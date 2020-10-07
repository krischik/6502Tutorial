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

setopt No_XTrace
setopt Err_Exit

git lfs update
git flow init || true

git config "credential.helper"  "store"
git config "push.default"       "current"
git config "pull.rebase"        "false"
git config "user.name"          "Martin Krischik"
git config "user.email"         "krischik@users.sourceforge.net"

git branch --set-upstream-to="remotes/origin/master"            "master"
git branch --set-upstream-to="remotes/origin/develop"           "develop"

git remote add "github" "https://github.com/krischik/6502Tutorial.git"
git remote add "gitlab" "https://gitlab.com/krischik/6502Tutorial.git"
git remote set-url origin "https://gitlab.com/krischik/6502Tutorial.git"
git fetch --all

pushd "Documents"
    git config "credential.helper"  "store"
    git config "push.default"       "current"
    git config "pull.rebase"        "false"
    git config "user.name"          "Martin Krischik"
    git config "user.email"         "krischik@users.sourceforge.net"

    git remote add "github" "https://github.com/krischik/6502Tutorial.wiki.git"
    git remote add "gitlab" "https://gitlab.com/krischik/6502Tutorial.wiki.git"
    git remote set-url origin "https://gitlab.com/krischik/6502Tutorial.wiki.git"
    git fetch --all

    # Important: Don't add lfs or flow support for the Wiki!
popd

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
