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

.if	    .defined(MACRO_ONY)

;;
;   Wait for instruction to finish
;
.macro	    LCD_Wait
.local	    Busy

	    PHA
	    VIA_Set_B	#%00000000		; Set Port B to all input

Busy:	    VIA_Out_A	#LCD::RW		; Start LCD read operation.
	    VIA_Out_A	#(LCD::RW | LCD::E)	; Enable Output if LCD status
	    BIT		VIA::IRB
	    BMI		Busy

	    VIA_Out_A	#LCD::RW		; End LCD read operation
	    VIA_Set_B	#%11111111		; Set Port B to all output
	    PLA
.endmacro

;;
;   Send Data to LCD display
;
.macro	    LCD_Control	Instruction
	    LCD_Wait
	    VIA_Out_B	{Instruction}
	    VIA_Out_A	#0			; Clear RS, RW, E bits
	    VIA_Out_A	#LCD::E			; Set E bit to send instruction
	    VIA_Out_A	#0			; Clear E bit
.endmacro

;;
;   Send Data to LCD display
;
.macro	    LCD_Print	Data
	    LCD_Wait
	    VIA_Out_B	{Data}
	    VIA_Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    VIA_Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    VIA_Out_A	#LCD::RS		; Clear E bit
.endmacro

.else

.pushseg

.segment    "ZEROPAGE"

;;
;   Storrage to perform the division needed for decimal output
;
Value:	    .word	0	    ; Dividend
Mod10:	    .word	0	    ; Remainder
Subtract:   .byte	0	    ; Subtract

.segment    "DATA"

;;
;   Text buffer for numeric output
;
Text:	    .res	5
Text_Len    =		* - Text

.segment    "CODE"

;;
;   Wait for instruction to finish
;
.proc	    Wait
	    PHA
	    VIA_Set_B	#%00000000		; Set Port B to all input

Busy:	    VIA_Out_A	#LCD::RW		; Start LCD read operation.
	    VIA_Out_A	#(LCD::RW | LCD::E)	; Enable Output if LCD status
	    BIT		VIA::IRB
	    BMI		Busy

	    VIA_Out_A	#LCD::RW		; End LCD read operation
	    VIA_Set_B	#%11111111		; Set Port B to all output
	    PLA
	    RTS
.endproc

.macro	    LCD_Wait
	    JSR		LCD::Wait
.endmacro

;;
;   Send Data to LCD display
;
.proc	    Control
	    JSR		LCD::Wait
	    VIA_Out_B
	    VIA_Out_A	#0			; Clear RS, RW, E bits
	    VIA_Out_A	#LCD::E			; Set E bit to send instruction
	    VIA_Out_A	#0			; Clear E bit
	    RTS
.endproc

.macro	    LCD_Control	Instruction
.ifnblank   Instruction
	    LDA		Instruction
.endif
	    JSR		LCD::Control
.endmacro

;;
;   Send Data to LCD display
;
.proc	    Print
	    JSR		Wait
	    VIA_Out_B
	    VIA_Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    VIA_Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    VIA_Out_A	#LCD::RS		; Clear E bit
	    RTS
.endproc

.macro	    LCD_Print	Character
.ifnblank   Character
	    LDA		Character
.endif
	    JSR		LCD::Print
.endmacro

.proc	    Print_Decimal
	    PHX					; Save X and Y register to stack
	    PHY
	    LDY		#(LCD::Text_Len)	; We start at the end of the text buffer

Divide:	    DEY					; And store the characters descending
	    STZ		LCD::Mod10		; Initialize Remainder with zero
	    STZ		LCD::Mod10 + 1
	    LDX		#16
	    CLC

Digit:	    ROL		LCD::Value		; Rotated dividend and remainder
	    ROL		LCD::Value + 1
	    ROL		LCD::Mod10
	    ROL		LCD::Mod10 + 1


	    LDA		LCD::Mod10		; Subtract 10 from Remainder
	    SUB		#10
	    STA		LCD::Subtract		; Temporary store low byte of subtraction
	    LDA		LCD::Mod10 + 1
	    SBC		#0
	    BCC		Ignore			; Skip if Remainder was smaller then 10

	    STA		LCD::Mod10 + 1		; Store subtracted value in remainder
	    LDA		LCD::Subtract		; restore low byte of subtraction
	    STA		LCD::Mod10

Ignore:	    DEX					; Continue for 16 rotations.
	    BNE		Digit

	    ROL		LCD::Value		; one last rotation for dividend
	    ROL		LCD::Value + 1
	    LDA		LCD::Mod10		; our next character is in remainder
	    ADD		#'0'
	    STA		LCD::Text,Y

	    LDA		LCD::Value		; stop when dividend is zero
	    ORA		LCD::Value + 1
	    BNE		Divide

; Print output. Note that Y now points to the first character. 

Loop:	    LCD_Print	{LCD::Text,Y}	; Write next character to Display
	    INY
	    CPY		#(LCD::Text_Len)	; Repeat loop until Y ≥ message length
	    BLT		Loop

	    PLY
	    PLX
	    RTS
.endproc

.macro	    LCD_Decimal	Number
	    PHA
	    LDA		Number			; Initialize parameter
	    STA		LCD::Value
	    LDA		Number + 1
	    STA		LCD::Value + 1

	    JSR		LCD::Print_Decimal

	    PLA
.endmacro

.popseg
.endif
.endscope

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker spell :
; vim: set spell spelllang=en_gb :
