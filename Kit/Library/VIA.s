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
; VIA register
;
.segment    "VIA"
.struct	    VIA
	    .ORG    $7F00
IORB	    .byte	       ; Output Register "B" Input Register "B"
IORA	    .byte	       ; Output Register "A" Input Register "A"
DDRB	    .byte	       ; Data Direction Register "B"
DDRA	    .byte	       ; Data Direction Register "A"
T1C_L	    .byte	       ; T1 Low-Order
T1C_H	    .byte	       ; T1 High-Order Counter
T1L_L	    .byte	       ; T1 Low-Order Latches
T1L_H	    .byte	       ; T1 High-Order Latches
T2C_L	    .byte	       ; T2 Low-Order
T2C_H	    .byte	       ; T2 High-Order Counter
SR	    .byte	       ; Shift Register
ACR	    .byte	       ; Auxiliary Control Register
PCR	    .byte	       ; Peripheral Control Register
IFR	    .byte	       ; Interrupt Flag Register
IER	    .byte	       ; Interrupt Enable Register
RA	    .byte	       ; Same as Reg 1 except no "Handshake"
.endstruct

;############################################################ {{{1 ##########
; vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
; vim: set textwidth=0 filetype=asm foldmethod=marker nospell :
