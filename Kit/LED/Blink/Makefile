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

Rom_Name	:= Blink_LED.rom
Include_Dir     := ../../Library
Source_Dir	:= src/main/asm
Config_File	:= rom.cfg
Object_Files	:= target/obj/Blink_LED.o
Map_File	:= target/Blink_LED.map

all rom:				    		\
    target/$(Rom_Name)

burn:					    		\
    target/$(Rom_Name)
	minipro -p "AT28C256" -w $(<)

clean:
	-rm -r target

rom_dump:				    		\
    target/$(Rom_Name)
	hexdump -C $(<)

rom_list:				    		\
    target/$(Rom_Name)
	da65 --cpu "65c02" --start-addr "8000" $(<) | grep --invert-match --word-regexp nop

target/$(Rom_Name):			    		\
    ${Object_Files}
	ld65				    		\
	    --obj-path	$(Include_Dir)	    		\
	    --lib-path	$(Include_Dir)	    		\
	    --cfg-path	$(Include_Dir)	    		\
	    --config	${Config_File}	    		\
	    --mapfile	$(basename $(@)).map		\
	    --dbgfile	$(basename $(@)).dbg		\
	    -o $(@)			    		\
	    ${+}

target/obj/Blink_LED.o:			    		\
    ${Source_Dir}/Blink_LED.s		    		\
    $(Include_Dir)/VIA.inc		    		\
    $(Include_Dir)/LCD.inc		    		\
    target				    		\
    target/obj

target/obj/%.o: ${Source_Dir}/%.s
	ca65				    		\
	    -W3				    		\
	    --cpu "65c02"		    		\
	    --include-dir $(Include_Dir)    		\
	    --listing $(basename $(@)).lst  		\
	    -o $(@)			    		\
	    $(<)

target:
	mkdir $(@)

target/obj:
	mkdir $(@)

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker :
# vim: set spell spelllang=en_gb :
