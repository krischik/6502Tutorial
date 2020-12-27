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

.segment    "ZEROPAGE"

Counter:    .res	2			; Count amount of button interrupts executed
Debounce:   .res	1			; Software de-bounce

.segment    "CODE"

;;
;   RES (reset) handler
;
.proc	    Do_RES
	    LDX		#$FF
	    TXS
	    CLI
	    STZ		Counter
	    STZ		Counter + 1

	    VIA_Set_A	#%11100000		; Set top 3 pin as output
	    VIA_Set_B	#%11111111		; Set all pins as output
	    VIA_Int_E   #%10100010		; Enable CA1 and T2 interrupts
	    VIA_Set_ACR #%00000000		; T1 & T2 timed interrupt, shift disable, latch disable
	    VIA_P_Ctrl  #%00000000		; Set CA1 to negative active edge

	    LCD_Control	#%00111000		; Set 8-bit mode; 2 line display; 5×8 font
	    LCD_Control	#%00001110		; Display on; cursor on; blink off
	    LCD_Control	#%00000110		; Increment and shift cursor; don't shift display
	    LCD_Control	#%00000001		; Clear Display

Loop:	    LCD_Control	#%00000010		; Move cursor home
	    LCD_Decimal	Counter			; Print number in decimal

	    WAI					; Wait for Interrupt
	    BRA		Loop
.endproc

;;
;   Increment Counter
;
.proc	    Inc_Counter
	    INC		Counter			; 16 bit increment
	    BNE		Exit
	    INC		Counter + 1
Exit:	    RTS
.endproc

;;
;   Restart button de-bounce timer. De-bouncing ends when one of two condition are meet:
;   
;   ⑴ 60ms have passed
;   ⑵ 5 key presses have passed.
;
;   I have chosen this to have a self healing algorithm which will reset even when
;   something goes wrong.
; 
.proc	    Start_Timer
	    VIA_Set_T2	#60000			; Set timer to 60ms at 1MHz
	    LDA		#5			; Skip up to 5 key presses		
	    STA		Debounce	
	    RTS
.endproc

;;
;   NMI (non-maskable interrupt) handler
;
.proc	    Do_NMI
	    PHA

	    LDA		Debounce		; Are we still de-bouncing buttons?
	    BNZ		Bounce			

	    JSR		Inc_Counter		; just increment the counter
	    JSR		Start_Timer
	    BRA		Exit

Bounce:     DEC		Debounce		; Decrement for key de-bounce
Exit:	    PLA
	    RTI
.endproc

;;
;   Handle interrupts from VIA
;
.proc	    Do_VIA_IRQ
	    PHA
	    LDA		#%00000010		; Check CA1 interrupt.
	    BIT		VIA::IFR
	    BZE		Check_T2		; Interrupt wasn't CA1, check next
	   
	    LDA		Debounce		; Are we still de-bouncing buttons?
	    BNZ		Bounce			

	    JSR		Inc_Counter		; increment the counter
	    BIT		VIA::ORA		; Clear CA1 interrupt
	    JSR		Start_Timer
	    BRA		Exit

Bounce:     DEC		Debounce		; Decrement for key de-bounce
	    BRA		Exit

Check_T2:   LDA		#%00100000		; Check Timer 2 interrupt
	    BIT		VIA::IFR      
	    BZE		Exit			; Interrupt wasn't Timer 2, check next
	    STZ		Debounce		; No button interrupt 60ms, clear counter.
	    LDA		VIA::T2C_L		; Clear Timer 2 Interrupt

Exit:	    PLA					; No more interrupt sources to check.
	    RTS
.endproc

;;
;   IRQ (interrupt request) hander
;
.proc	    Do_IRQ
	    BIT		VIA::IFR
	    BPL		Exit			; Interrupt wasn't from VIA, check next
	    JSR		Do_VIA_IRQ
Exit:	    RTI					; No more interrupt sources to check.
.endproc

.segment    "HEADER"
.word	    Do_NMI
.word	    Do_RES
.word	    Do_IRQ

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker spell :
; vim: set spell spelllang=en_gb :
