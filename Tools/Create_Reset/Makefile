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

Tool_Name := Create_Reset
Rom_Name  := Reset.rom

all:					    \
    target/$(Tool_Name)

rom:					    \
    target/$(Rom_Name)

burn:					    \
    target/$(Rom_Name)
	minipro -p "AT28C256" -w $(<)

pretty:
	gnat pretty -P $(Tool_Name).gpr

clean:
	gnat clean -P $(Tool_Name).gpr
	-rm -r target
	-rm src/main/ada/*.npp

error1:					    \
    target/$(Tool_Name)
	target/$(Tool_Name) non_existing_directory/$(Rom_Name)

target/$(Rom_Name):			    \
    target/$(Tool_Name)
	target/$(Tool_Name) $(@)

target/$(Tool_Name):			    \
    $(Tool_Name).gpr			    \
    src/main/ada/$(Tool_Name).adb	    \
    target				    \
    target/obj				    \
    target/lib
	gnat make -Xstyle=Release -P $(<)	 || \
	cat target/obj/$(Tool_Name).adb.stderr

target:
	mkdir $(@)

target/obj:
	mkdir $(@)

target/lib:
	mkdir $(@)

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker :
# vim: set spell spelllang=en_gb :
