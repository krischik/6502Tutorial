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

.pc02
.listbytes  16
.pagelength 66
.case	    -

.macpack    generic
.include    "VIA.inc"
.include    "LCD.inc"

.segment    "RODATA"

Message:    .byte	"Hello World!"
Message_Len =		* - Message

.segment    "CODE"

Do_RES:	    LDX		#$FF
	    TXS

	    Set_A	#%11100000		; Set top 3 pin as output
	    Set_B	#%11111111		; Set all pins as output

	    Control_LCD	#%00111000		; Set 8-bit mode; 2 line display; 5×8 font
	    Control_LCD	#%00001110		; Display in; cursor on; blink off
	    Control_LCD	#%00000110		; Increment and shift cursor; don't shift display
	    Control_LCD	#%00000001		; Clear Display

	    LDX		#$00
Loop:	    Data_LCD	{Message,X}		; Write next character to Display
	    INX
	    CPX		#(Message_Len)		; Repeat lopp until X ≥ message lenght
	    BLT		Loop

	    STP					; Stop Processor

Do_NMI:	    RTI

Do_IRQ:	    RTI

.segment    "HEADER"
.word	    Do_NMI
.word	    Do_RES
.word	    Do_IRQ

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm foldmethod=marker nospell :
; vim: set spell spelllang=en_gb :