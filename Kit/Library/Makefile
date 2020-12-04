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

.PHONY: all rom burn clean rom_dump rom_list

Include_Dir     := ../Library
Config_File	:= rom.cfg
Object_Files	:= target/obj/LCD.o
Map_File	:= target/Division.map

all:					    \
    ${Object_Files} 

clean:
	-rm -r target

target/obj/LCD.o:			    \
    src/main/asm/LCD.s			    \
    target				    \
    target/obj

target/obj/%.o:	src/main/asm/%.s
	ca65						\
	    -W1				    		\
	    --cpu "65c02"		    		\
	    --include-dir $(Include_Dir)/src/main/asm   \
	    --listing $(basename $(@)).lst		\
	    -o $(@)					\
	    $(<)

target:
	mkdir $(@)

target/obj:
	mkdir $(@)

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker :
# vim: set spell spelllang=en_gb :
