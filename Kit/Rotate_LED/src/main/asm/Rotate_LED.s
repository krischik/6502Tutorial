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
ORB	    =	    $7F00
DDRB	    =	    $7F02

;;
;   Set VIA data directon register B
;
.macro	    Set_B   Value
.ifnblank	    Value
	    LDA	    Value
.endif
	    STA	    DDRB
.endmacro

;;
;   Set VIA output register B
;
.macro	    Out_B   Value
.ifnblank	    Value
	    LDA	    Value
.endif
	    STA	    ORB
.endmacro

;;
;   Logical rotate right accumulator
;
.macro	    L_ROR
.local	    Skip
	    LSR
	    BCC	    Skip
	    ORA	    #$80
Skip:
.endmacro

;;
;   Logical rotate left accumulator
;
.macro	    L_ROL
	    ASL
	    ADC	    #0
.endmacro

.segment    "CODE"

Do_RES:	    Set_B   #$FF
	    Out_B   #$50

Loop:	    L_ROR
	    Out_B
	    BRA	    Loop

Do_NMI:	    RTI

Do_IRQ:	    RTI

.segment    "HEADER"
.word	    Do_NMI
.word	    Do_RES
.word	    Do_IRQ

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=a65 foldmethod=marker nospell :
