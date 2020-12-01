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
;   Logical rotate right accumulator
;
.macro	    LRR
.local	    Skip
	    LSR
	    BCC	    Skip
	    ORA	    #$80
Skip:
.endmacro

;;
;   Logical rotate left accumulator
;
.macro	    LRL
	    ASL
	    ADC	    #$00
.endmacro

;;
;   Arithmetic shift right accumulator
;
.macro	    ASR
	    CMP     #$80    ; Put bit 7 into carry
	    ROR             ; Rotate right with carry
.endmacro

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker spell :
; vim: set spell spelllang=en_gb :
