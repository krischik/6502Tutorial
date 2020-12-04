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
;   Logical (without carry) rotate right
;
.macro	    LRR	    Value
.local	    Skip
	    LSR	    Value
	    BCC	    Skip
	    ORA	    #$80
Skip:
.endmacro

;;
;   Logical (without carry) rotate left
;
.macro	    LRL	    Value
	    ASL	    Value
	    ADC	    #$00	; Set low bit to carry
.endmacro

;;
;   Arithmetic shift right accumulator
;
.macro	    ASR	    Value
	    CMP     #$80	; Put bit 7 into carry
	    ROR	    Value	; Rotate right with carry
.endmacro


;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker spell :
; vim: set spell spelllang=en_gb :
