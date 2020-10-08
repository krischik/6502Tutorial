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

.PHONY: all clean run
.SUFFIXES:

Exe_File	= HELLO.COM
Object_Files	= HelloWorld.o
System_Files	= "/opt/local/share/atari800"
User_Files	= "$(HOME)/Library/Application\ Support/Atari800"

all: $(Exe_File)

clean: 
	rm -v *.COM *.o *.s

run: $(Exe_File)
	/usr/local/bin/atari800				\
	    -autosave-config				\
	    -cart-type 1				\
	    -hreadwrite					\
	    -video-accel				\
	    -320xe					\
	    -nobasic					\
	    -pal					\
	    -win-height	    1120			\
	    -win-width	    1680			\
	    -config	"$(CURDIR)/HelloWorld.cfg"	\
	    -H1		"$(CURDIR)"			\
	    -xlxe_rom	"$(System_Files)/ATARIXL.ROM"	\
	    "$(User_Files)/Disks/CC65-Development.xfd"

$(Exe_File): ${Object_Files}
	ld65 --target atari -o $(@) $(+)
HelloWorld.o: HelloWorld.s

%.o: %.s
	ca65 --target atari -o $(@) $(<)

# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=0 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
