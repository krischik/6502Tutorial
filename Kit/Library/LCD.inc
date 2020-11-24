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

.if	.defined(MACRO_ONY)

;;
;   Send Data to LCD display
;
.macro	    LCD_Control	Instruction
	    VIA_Out_B	{Instruction}
	    VIA_Out_A	#0			; Clear RS, RW, E bits
	    VIA_Out_A	#LCD::E			; Set E bit to send instruction
	    VIA_Out_A	#0			; Clear E bit
.endmacro



;;
;   Send Data to LCD display
;
.macro	    LCD_Data	Data
	    VIA_Out_B	{Data}
	    VIA_Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    VIA_Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    VIA_Out_A	#LCD::RS		; Clear E bit
.endmacro

.else

.pushseg
.segment    "CODE"

;;
;   Send Data to LCD display
;
.proc	    Control
	    VIA_Out_B
	    VIA_Out_A	#0			; Clear RS, RW, E bits
	    VIA_Out_A	#LCD::E			; Set E bit to send instruction
	    VIA_Out_A	#0			; Clear E bit
	    RTS
.endproc

.macro	    LCD_Control	Instruction
	    LDA		Instruction
	    JSR		LCD::Control
.endmacro

;;
;   Send Data to LCD display
;
.proc	    DATA
	    VIA_Out_B
	    VIA_Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    VIA_Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    VIA_Out_A	#LCD::RS		; Clear E bit
	    RTS
.endproc

.macro	    LCD_Data	Character
	    LDA		Character
	    JSR		LCD::Data
.endmacro

.popseg

.endif

.endscope

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm foldmethod=marker nospell :
