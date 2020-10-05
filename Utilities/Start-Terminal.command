#!/usr/bin/osascript
------------------------------------------------------------ {{{1 -----------
--  Copyright © 2007 … 2017 Martin Krischik
-----------------------------------------------------------------------------
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
------------------------------------------------------------ }}}1 -----------

set |PROJECT HOME| to (system attribute "PROJECT_HOME")

tell application "Terminal"
    set |Tab| to do script "
source \"" & |PROJECT HOME| & "/Utilities/Setup.command\";
cd \"" & |PROJECT HOME| & "\""
    set current settings of |Tab| to settings set ("MacPorts")
    set background color of |Tab| to {57344, 57344, 65535}
    set custom title of |Tab| to ("MacPorts")
end tell

------------------------------------------------------------ {{{1 -----------
-- vim: set wrap tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab nospell :
-- vim: set textwidth=0 fileencoding=utf8 fileformat=unix filetype=applescript foldmethod=marker :
