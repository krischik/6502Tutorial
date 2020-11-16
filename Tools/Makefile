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

Tool_Names := Create_NOP Create_Reset Create_LED

all:
	$(MAKE) --directory=Create_NOP	    all
	$(MAKE) --directory=Create_Reset    all
	$(MAKE) --directory=Create_LED	    all

rom:					    
	$(MAKE) --directory=Create_NOP	    rom
	$(MAKE) --directory=Create_Reset    rom
	$(MAKE) --directory=Create_LED	    rom


pretty:
	$(MAKE) --directory=Create_NOP	    pretty
	$(MAKE) --directory=Create_Reset    pretty
	$(MAKE) --directory=Create_LED	    pretty

clean:
	$(MAKE) --directory=Create_NOP	    clean
	$(MAKE) --directory=Create_Reset    clean
	$(MAKE) --directory=Create_LED	    clean

############################################################# {{{1 ##########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
