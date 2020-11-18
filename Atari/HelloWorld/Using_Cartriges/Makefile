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

Cartrige_File	= target/HELLO.CAR
Object_Files	= target/obj/HelloWorld.o
Map_File	= target/HELLO.MAP
System_Files	= "/opt/local/share/atari800"
User_Files	= "$(HOME)/Library/Application\ Support/Atari800"

all: $(Cartrige_File)

clean:
	rm -r target

run: Test.car
	atari800						\
	    -autosave-config					\
	    -cart-type 1					\
	    -hreadwrite						\
	    -video-accel					\
	    -xe							\
	    -nobasic						\
	    -pal						\
	    -win-height	    1120				\
	    -win-width	    1680				\
	    -config	"$(CURDIR)/target/HelloWorld.cfg"	\
	    -H1		"$(CURDIR)/target"			\
	    -cart	"$(Cartrige_File)"			\
	    -xlxe_rom	"$(System_Files)/ATARIXL.ROM"		\
	    "$(User_Files)/Disks/CC65-Development.xfd"

$(Cartrige_File): ${Object_Files}
	ld65				\
	    -D__CARTSIZE__=0x2000	\
	    -D__CART_HEADER__=0xBFFA	\
	    -C atari-cart.cfg		\
	    -o  $(@)			\
	    $(+)

target/obj/HelloWorld.o:	\
    src/main/asm/HelloWorld.s	\
    target/obj

target/obj/%.o: src/main/asm/%.s
	ca65 --target atari -o $(@) $(<)

target/obj:
	mkdir -p $(@)

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=0 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
