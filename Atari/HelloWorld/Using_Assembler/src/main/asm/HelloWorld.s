;############################################################ {{{1 ##########
;  Copyright © 2012 … 2020 Martin Krischik «krischik@users.sourceforge.net»
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
;
.INCLUDE	"atari.inc"
.MACPACK	atari
;
; CIO EQUATES
; ===========
;
IOCB0_ICHID	= IOCB+$00	;DEVICE HANDLER
IOCB0_ICDNO	= IOCB+$00	;DEVICE NUMBER
IOCB0_ICCOM	= IOCB+$00	;I/O COMMAND
IOCB0_ICSTA	= IOCB+$00	;I/O STATUS
IOCB0_ICBAL	= IOCB+$00	;LSB BUFFER ADDR
IOCB0_ICBAH	= IOCB+$00	;MSB BUFFER ADDR
IOCB0_ICPTL	= IOCB+$00	;LSB PUT ROUTINE
IOCB0_ICPTH	= IOCB+$00	;MSB PUT ROUTINE
IOCB0_ICBLL	= IOCB+$00	;LSB BUFFER LEN
IOCB0_ICBLH	= IOCB+$00	;MSB BUFFER LEN
IOCB0_ICAX1	= IOCB+$00	;AUX BYTE 1
IOCB0_ICAX2	= IOCB+$00	;AUX BYTE 2
IOCB0_ICAX3	= IOCB+$00	;AUX BYTE 3
IOCB0_ICAX4	= IOCB+$00	;AUX BYTE 4
IOCB0_ICAX5	= IOCB+$00	;AUX BYTE 5
IOCB0_ICAX6	= IOCB+$00	;AUX BYTE 6
;
LC_8K		= $A000		; Start of Left 8k Cartridge
;
; SETUP FOR CIO
; -------------

.SEGMENT	"CODE"
.ORG		LC_8K

start:		LDX #0			;IOCB 0
		LDA #PUTREC		;WANT OUTPUT
		STA IOCB0_ICCOM,X	;ISSUE CMD
		LDA #MSG&255		;LOW BYTE OF MSG
		STA IOCB0_ICBAL,X	; INTO ICBAL
		LDA #MSG/256		;HIGH BYTE
		STA IOCB0_ICBAH,X	; INTO ICBAH
		LDA #0			;LENGTH OF MSG
		STA IOCB0_ICBLH,X	; HIGH BYTE
		LDA #$FF		;255 CHAR LENGTH
		STA IOCB0_ICBLL,X	; LOW BYTE
;
; CALL CIO TO PRINT
; -----------------
		JSR CIOV	;CALL CIO
		RTS		;EXIT TO DOS

INIT:
		RTS		;EXIT TO DOS
;
; OUR MESSAGE
; -----------
;
.SEGMENT	"RODATA"
MSG:
.BYTE		"HELLO WORLD!",EOL

.segment        "STARTUP"

		RTS		; fix for SpartaDOS / OS/A+
				; They first call the entry point from AUTOSTRT; and
                		; then, the load address (this rts here).
                		; We point AUTOSTRT directly after the rts.
syschk:		RTS

__SYSTEM_CHECK__=syschk

.export         __SYSTEM_CHECK__
.export         __EXEHDR__: absolute = 1
.import         __MAIN_START__, __BSS_LOAD__
.export         __AUTOSTART__: absolute = 1

.segment "AUTOSTRT"
.word		RUNAD                   ; defined in atari.inc
.word   	RUNAD+1
.word   	start


.segment        "EXEHDR"
.word		$FFFF

.segment        "MAINHDR"
.word		__MAIN_START__
.word		__BSS_LOAD__ - 1

; vim: set nowrap tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab :
; vim: set textwidth=0 filetype=asm_ca65 foldmethod=marker nospell :
