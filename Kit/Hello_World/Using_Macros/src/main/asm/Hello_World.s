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

.segment    "CODE"

Do_RES:	    VIA_Set_A	#%11100000		; Set top 3 pin as output
	    VIA_Set_B	#%11111111		; Set all pins as output

	    LCD_Control	#%00111000		; Set 8-bit mode; 2 line display; 5×8 font
	    LCD_Control	#%00001110		; Display in; cursor on; blink off
	    LCD_Control	#%00000110		; Increment and shift cursor; don't shift display
	    LCD_Control	#%00000001		; Clear Display

	    LCD_Print	#'H'			; Send character 'H' to display
	    LCD_Print	#'e'			; Send character 'e' to display
	    LCD_Print	#'l'			; Send character 'l' to display
	    LCD_Print	#'l'			; Send character 'l' to display
	    LCD_Print	#'o'			; Send character 'o' to display
	    LCD_Print	#','			; Send character ',' to display
	    LCD_Print	#' '			; Send character ' ' to display
	    LCD_Print	#'W'			; Send character 'W' to display
	    LCD_Print	#'o'			; Send character 'o' to display
	    LCD_Print	#'r'			; Send character 'r' to display
	    LCD_Print	#'l'			; Send character 'l' to display
	    LCD_Print	#'d'			; Send character 'd' to display
	    LCD_Print	#'!'			; Send character '!' to display

	    STP					; Stop Processor

Do_NMI:	    RTI

Do_IRQ:	    RTI

.segment    "HEADER"
.word	    Do_NMI
.word	    Do_RES
.word	    Do_IRQ

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=a65 foldmethod=marker nospell :
; vim: set spell spelllang=en_gb :
