;############################################################ {{{1 ##########
;  Copyright © 2020 … 2020 Martin Krischik «krischik@users.sourceforge.net»
;############################################################################
;  This program is free software: you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation, either version 3 of the License, or
;  (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program.  If not, see «http://www.gnu.org/licenses/».
;############################################################ }}}1 ##########

;;
; LCD Display
;
.scope	    LCD

E	    =		%10000000
RW	    =		%01000000
RS	    =		%00100000

;;
;   Send Data to LCD display
;
.macro	    Control_LCD	Instruction
	    Out_B	{Instruction}
	    Out_A	#0			; Clear RS, RW, E bits
	    Out_A	#LCD::E			; Set E bit to send instruction
	    Out_A	#0			; Clear E bit
.endmacro

;;
;   Send Data to LCD display
;
.macro	    Data_LCD	Data
	    Out_B	{Data}
	    Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    Out_A	#LCD::RS		; Clear E bit
.endmacro

.endscope

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm foldmethod=marker nospell :
