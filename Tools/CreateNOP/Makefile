############################################################# {{{1 ##########
#  Copyright © 2012 … 2020 Martin Krischik «krischik@users.sourceforge.net»
#############################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see «http://www.gnu.org/licenses/».
############################################################# }}}1 ##########

all:					\
    target/createnop

target/createnop:			\
    	CreateNOP.gpr			\
    	src/main/ada/createnop.adb 	\
	target				\
	target/obj			\
	target/lib
	gnat make -Xstyle=Debug -P $(<)	     || \
	cat target/obj/createnop.adb.std* 

target:
	mkdir $(@)

target/obj:
	mkdir $(@)
target/lib:
	mkdir $(@)

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=0 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
