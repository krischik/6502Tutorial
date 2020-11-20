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

;;
; VIA register
;
.segment    "VIA"
.scope	    VIA
IORB	    =		$7F00			; Output Register "B" Input Register "B"
IORA	    =		$7F01			; Output Register "A" Input Register "A"
DDRB	    =		$7F02			; Data Direction Register "B"
DDRA	    =		$7F03			; Data Direction Register "A"
T1C_L	    =		$7F04			; T1 Low-Order
T1C_H	    =		$7F05			; T1 High-Order Counter
T1L_L	    =		$7F06			; T1 Low-Order Latches
T1L_H	    =		$7F07			; T1 High-Order Latches
T2C_L	    =		$7F08			; T2 Low-Order
T2C_H	    =		$7F09			; T2 High-Order Counter
SR	    =		$7F0A			; Shift Register
ACR	    =		$7F0B			; Auxiliary Control Register
PCR	    =		$7F0C			; Peripheral Control Register
IFR	    =		$7F0D			; Interrupt Flag Register
IER	    =		$7F0E			; Interrupt Enable Register
RA	    =		$7F0F			; Same as Reg 1 except no "Handshake"

;;
;   Set VIA data direction register A
;
.macro	    Set_A	Value
	    LDA		Value
	    STA		VIA::DDRA
.endmacro

;;
;   Set VIA data direction register B
;
.macro	    Set_B	Value
	    LDA		Value
	    STA		VIA::DDRB
.endmacro

;;
;   Set VIA output register A
;
.macro	    Out_A	Value
	    LDA		Value
	    STA		VIA::IORA
.endmacro

;;
;   Set VIA output register B
;
.macro	    Out_B	Value
	    LDA		Value
	    STA		VIA::IORB
.endmacro

.endscope

;;
; LCD Display
;
.scope LCD
E	    =		%10000000
RW	    =		%01000000
RS	    =		%00100000

;;
;   Send Data to LCD display
.macro	    Control_LCD	Instruction
	    Out_B	Instruction
	    Out_A	#0			; Clear RS, RW, E bits
	    Out_A	#LCD::E			; Set E bit to send instruction
	    Out_A	#0			; Clear E bit
.endmacro

;;
;   Send Data to LCD display
.macro	    Data_LCD	Data
	    Out_B	Data
	    Out_A	#LCD::RS		; Set RS, Clear RW, E bits
	    Out_A	#(LCD::RS | LCD::E)	; Set E bit to send data
	    Out_A	#LCD::RS		; Clear E bit
.endmacro

.endscope

.segment    "CODE"

Do_RES:	    Set_A	#%11100000		; Set top 3 pin as output
	    Set_B	#%11111111		; Set all pins as output

	    Control_LCD	#%00111000		; Set 8-bit mode; 2 line display; 5×8 font
	    Control_LCD	#%00001110		; Display in; cursor on; blink off
	    Control_LCD	#%00000110		; Increment and shift cursor; don't shift display
	    Control_LCD	#%00000001		; Clear Display

	    Data_LCD	#'H'			; Send character 'H' to display
	    Data_LCD	#'e'			; Send character 'e' to display
	    Data_LCD	#'l'			; Send character 'l' to display
	    Data_LCD	#'l'			; Send character 'l' to display
	    Data_LCD	#'o'			; Send character 'o' to display
	    Data_LCD	#','			; Send character ',' to display
	    Data_LCD	#' '			; Send character ' ' to display
	    Data_LCD	#'W'			; Send character 'W' to display
	    Data_LCD	#'o'			; Send character 'o' to display
	    Data_LCD	#'r'			; Send character 'r' to display
	    Data_LCD	#'l'			; Send character 'l' to display
	    Data_LCD	#'d'			; Send character 'd' to display
	    Data_LCD	#'!'			; Send character '!' to display

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
