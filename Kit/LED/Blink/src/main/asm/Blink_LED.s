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
.case	    +

.segment    "VIA"
ORB	    =		$7F00
DDRB	    =		$7F02

.macro	    Set_B	value
	    LDA		value
	    STA		DDRB
.endmacro

.macro	    Out_B	value
	    LDA		value
	    STA		ORB
.endmacro

.segment    "CODE"

DO_RES:	    Set_B	#$FF

loop:	    Out_B	#$55
	    Out_B	#$AA
	    BRA		loop

DO_NMI:	    RTI

DO_IRQ:	    RTI

.segment    "HEADER"
.word	    DO_NMI
.word	    DO_RES
.word	    DO_IRQ

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker spell :
; vim: set spell spelllang=en_gb :
