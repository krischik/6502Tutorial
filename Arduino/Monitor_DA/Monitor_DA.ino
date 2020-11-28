/*********************************************************** {{{1 ***********
* Copyright © 2020 … 2020 Martin Krischik «krischik@users.sourceforge.net»
*****************************************************************************
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see «http://www.gnu.org/licenses/».
************************************************************* }}}1 *********/

#include <USBAPI.h>

/**
 * Bus class handles reading the 6502 address and data bus
 */
class Bus
{
private:
    /**
     * Size of the 6502 bus (16 for address bus and 8 for data bus).
     */
    size_t const Size;
    /**
     * Arduino I/O lines the 6502 bus is connected to.
     */
    byte const* Lines;

public:
    /**
     * initialise Bus.
     *
     * @param Size of the 6502 bus (16 for address bus and 8 for data bus).
     * @param Arduino I/O lines the 6502 bus is connected to.
     */
    Bus (const byte Lines[], size_t Size) :
        Size (Size),
        Lines (Lines)
    {
    } // Bus

    /**
     * initialize the Arduino I/O lines used to monitor the 6502 bus to INPUT.
     */
    void Init () const
    {
        for (size_t i = 0;
             i < Size;
             i++)
        {
            pinMode (Lines[i], INPUT);
        } // for

        return;
    } // Init

    /**
     * read the but date from the Arduino I/O lines.
     *
     * @return value read.
     */
    word Read () const
    {
        word Retval = 0;

        for (size_t i = 0;
             i < Size;
             i++)
        {
            auto bit = digitalRead (Lines[i]) == HIGH ? 1 : 0;

            Serial.print (bit);

            Retval = (Retval << 1) + bit;
        } // for

        Serial.print (" ");

        return Retval;
    } // Read
}; // Bus

/**
 * Address bus
 */
static Bus const A = Bus (
    (byte[16]) {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52},
    16);

/**
 * Data bus
 */
static Bus const D = Bus (
    (byte[8]) {39, 41, 43, 45, 47, 49, 51, 53},
    8);

static String const Opcodes[] = {
    /* 00 => */ "BRK",
    /* 01 => */ "ORA (dp,X)",
    /* 02 => */ "COP const",
    /* 03 => */ "ORA sr,S",
    /* 04 => */ "TSB dp",
    /* 05 => */ "ORA dp",
    /* 06 => */ "ASL dp",
    /* 07 => */ "ORA [dp]",
    /* 08 => */ "PHP",
    /* 09 => */ "ORA #const",
    /* 0A => */ "ASL A",
    /* 0B => */ "PHD",
    /* 0C => */ "TSB addr",
    /* 0D => */ "ORA addr",
    /* 0E => */ "ASL addr",
    /* 0F => */ "ORA long",
    /* 10 => */ "BPL nearlabel",
    /* 11 => */ "ORA (dp),Y",
    /* 12 => */ "ORA (dp)",
    /* 13 => */ "ORA (sr,S),Y",
    /* 14 => */ "TRB dp",
    /* 15 => */ "ORA dp,X",
    /* 16 => */ "ASL dp,X",
    /* 17 => */ "ORA [dp],Y",
    /* 18 => */ "CLC",
    /* 19 => */ "ORA addr,Y",
    /* 1A => */ "INA",
    /* 1B => */ "TCS",
    /* 1C => */ "TRB addr",
    /* 1D => */ "ORA addr,X",
    /* 1E => */ "ASL addr,X",
    /* 1F => */ "ORA long,X",
    /* 20 => */ "JSR addr",
    /* 21 => */ "AND (dp,X)",
    /* 22 => */ "JSR long",
    /* 23 => */ "AND sr,S",
    /* 24 => */ "BIT dp",
    /* 25 => */ "AND dp",
    /* 26 => */ "ROL dp",
    /* 27 => */ "AND [dp]",
    /* 28 => */ "PLP",
    /* 29 => */ "AND #const",
    /* 2A => */ "ROL A",
    /* 2B => */ "PLD",
    /* 2C => */ "BIT addr",
    /* 2D => */ "AND addr",
    /* 2E => */ "ROL addr",
    /* 2F => */ "AND long",
    /* 30 => */ "BMI nearlabel",
    /* 31 => */ "AND (dp),Y",
    /* 32 => */ "AND (dp)",
    /* 33 => */ "AND (sr,S),Y",
    /* 34 => */ "BIT dp,X",
    /* 35 => */ "AND dp,X",
    /* 36 => */ "ROL dp,X",
    /* 37 => */ "AND [dp],Y",
    /* 38 => */ "SEC",
    /* 39 => */ "AND addr,Y",
    /* 3A => */ "DEA",
    /* 3B => */ "TSC",
    /* 3C => */ "BIT addr,X",
    /* 3D => */ "AND addr,X",
    /* 3E => */ "ROL addr,X",
    /* 3F => */ "AND long,X",
    /* 40 => */ "RTI",
    /* 41 => */ "EOR (dp,X)",
    /* 42 => */ "WDM",
    /* 43 => */ "EOR sr,S",
    /* 44 => */ "MVN srcbk,destbk",
    /* 45 => */ "EOR dp",
    /* 46 => */ "LSR dp",
    /* 47 => */ "EOR [dp]",
    /* 48 => */ "PHA",
    /* 49 => */ "EOR #const",
    /* 4A => */ "LSR A",
    /* 4B => */ "PHK",
    /* 4C => */ "JMP addr",
    /* 4D => */ "EOR addr",
    /* 4E => */ "LSR addr",
    /* 4F => */ "EOR long",
    /* 50 => */ "BVC nearlabel",
    /* 51 => */ "EOR (dp),Y",
    /* 52 => */ "EOR (dp)",
    /* 53 => */ "EOR (sr,S),Y",
    /* 54 => */ "MVN srcbk,destbk",
    /* 55 => */ "EOR dp,X",
    /* 56 => */ "LSR dp,X",
    /* 57 => */ "EOR [dp],Y",
    /* 58 => */ "CLI",
    /* 59 => */ "EOR addr,Y",
    /* 5A => */ "PHY",
    /* 5B => */ "TCD",
    /* 5C => */ "JMP long",
    /* 5D => */ "EOR addr,X",
    /* 5E => */ "LSR addr,X",
    /* 5F => */ "EOR long,X",
    /* 60 => */ "RTS",
    /* 61 => */ "ADC (dp,X)",
    /* 62 => */ "PER label",
    /* 63 => */ "ADC sr,S",
    /* 64 => */ "STZ dp",
    /* 65 => */ "ADC dp",
    /* 66 => */ "ROR dp",
    /* 67 => */ "ADC [dp]",
    /* 68 => */ "PLA",
    /* 69 => */ "ADC #const",
    /* 6A => */ "ROR A",
    /* 6B => */ "RTL",
    /* 6C => */ "JMP (addr)",
    /* 6D => */ "ADC addr",
    /* 6E => */ "ROR addr",
    /* 6F => */ "ADC long",
    /* 70 => */ "BVS nearlabel",
    /* 71 => */ "ADC (dp),Y",
    /* 72 => */ "ADC (dp)",
    /* 73 => */ "ADC (sr,S),Y",
    /* 74 => */ "STZ dp,X",
    /* 75 => */ "ADC dp,X",
    /* 76 => */ "ROR dp,X",
    /* 77 => */ "ADC [dp],Y",
    /* 78 => */ "SEI",
    /* 79 => */ "ADC addr,Y",
    /* 7A => */ "PLY",
    /* 7B => */ "TDC",
    /* 7C => */ "JMP (addr,X)",
    /* 7D => */ "ADC addr,X",
    /* 7E => */ "ROR addr,X",
    /* 7F => */ "ADC long,X",
    /* 80 => */ "BRA nearlabel",
    /* 81 => */ "STA (dp,X)",
    /* 82 => */ "BRL label",
    /* 83 => */ "STA sr,S",
    /* 84 => */ "STY dp",
    /* 85 => */ "STA dp",
    /* 86 => */ "STX dp",
    /* 87 => */ "STA [dp]",
    /* 88 => */ "DEY",
    /* 89 => */ "BIT #const",
    /* 8A => */ "TXA",
    /* 8B => */ "PHB",
    /* 8C => */ "STY addr",
    /* 8D => */ "STA addr",
    /* 8E => */ "STX addr",
    /* 8F => */ "STA long",
    /* 90 => */ "BCC nearlabel",
    /* 91 => */ "STA (dp),Y",
    /* 92 => */ "STA (dp)",
    /* 93 => */ "STA (sr,S),Y",
    /* 94 => */ "STY dp,X",
    /* 95 => */ "STA dpX",
    /* 96 => */ "STX dp,Y",
    /* 97 => */ "STA [dp],Y",
    /* 98 => */ "TYA",
    /* 99 => */ "STA addr,Y",
    /* 9A => */ "TXS",
    /* 9B => */ "TXY",
    /* 9C => */ "STZ addr",
    /* 9D => */ "STA addr,X",
    /* 9E => */ "STZ addr,X",
    /* 9F => */ "STA long,X",
    /* A0 => */ "LDY #const",
    /* A1 => */ "LDA (dp,X)",
    /* A2 => */ "LDX #const",
    /* A3 => */ "LDA sr,S",
    /* A4 => */ "LDY dp",
    /* A5 => */ "LDA dp",
    /* A6 => */ "LDX dp",
    /* A7 => */ "LDA [dp]",
    /* A8 => */ "TAY",
    /* A9 => */ "LDA #const",
    /* AA => */ "TAX",
    /* AB => */ "PLB",
    /* AC => */ "LDY addr",
    /* AD => */ "LDA addr",
    /* AE => */ "LDX addr",
    /* AF => */ "LDA long",
    /* B0 => */ "BCS nearlabel",
    /* B1 => */ "LDA (dp),Y",
    /* B2 => */ "LDA (dp)",
    /* B3 => */ "LDA (sr,S),Y",
    /* B4 => */ "LDY dp,X",
    /* B5 => */ "LDA dp,X",
    /* B6 => */ "LDX dp,Y",
    /* B7 => */ "LDA [dp],Y",
    /* B8 => */ "CLV",
    /* B9 => */ "LDA addr,Y",
    /* BA => */ "TSX",
    /* BB => */ "TYX",
    /* BC => */ "LDY addr,X",
    /* BD => */ "LDA addr,X",
    /* BE => */ "LDX addr,Y",
    /* BF => */ "LDA long,X",
    /* C0 => */ "CPY #const",
    /* C1 => */ "CMP (dp,X)",
    /* C2 => */ "REP #const",
    /* C3 => */ "CMP sr,S",
    /* C4 => */ "CPY dp",
    /* C5 => */ "CMP dp",
    /* C6 => */ "DEC dp",
    /* C7 => */ "CMP [dp]",
    /* C8 => */ "INY",
    /* C9 => */ "CMP #const",
    /* CA => */ "DEX",
    /* CB => */ "WAI",
    /* CC => */ "CPY addr",
    /* CD => */ "CMP addr",
    /* CE => */ "DEC addr",
    /* CF => */ "CMP long",
    /* D0 => */ "BNE nearlabel",
    /* D1 => */ "CMP (dp),Y",
    /* D2 => */ "CMP (dp)",
    /* D3 => */ "CMP (sr,S),Y",
    /* D4 => */ "PEI (dp)",
    /* D5 => */ "CMP dp,X",
    /* D6 => */ "DEC dp,X",
    /* D7 => */ "CMP [dp],Y",
    /* D8 => */ "CLD",
    /* D9 => */ "CMP addr,Y",
    /* DA => */ "PHX",
    /* DB => */ "STP",
    /* DC => */ "JMP [addr]",
    /* DD => */ "CMP addr,X",
    /* DE => */ "DEC addr,X",
    /* DF => */ "CMP long,X",
    /* E0 => */ "CPX #const",
    /* E1 => */ "SBC (dp,X)",
    /* E2 => */ "SEP #const",
    /* E3 => */ "SBC sr,S",
    /* E4 => */ "CPX dp",
    /* E5 => */ "SBC dp",
    /* E6 => */ "INC dp",
    /* E7 => */ "SBC [dp]",
    /* E8 => */ "INX",
    /* E9 => */ "SBC #const",
    /* EA => */ "NOP",
    /* EB => */ "XBA",
    /* EC => */ "CPX addr",
    /* ED => */ "SBC addr",
    /* EE => */ "INC addr",
    /* EF => */ "SBC long",
    /* F0 => */ "BEQ nearlabel",
    /* F1 => */ "SBC (dp),Y",
    /* F2 => */ "SBC (dp)",
    /* F3 => */ "SBC (sr,S),Y",
    /* F4 => */ "PEA addr",
    /* F5 => */ "SBC dp,X",
    /* F6 => */ "INC dp,X",
    /* F7 => */ "SBC [dp],Y",
    /* F8 => */ "SED",
    /* F9 => */ "SBC addr,Y",
    /* FA => */ "PLX",
    /* FB => */ "XCE",
    /* FC => */ "JSR (addr,X)",
    /* FD => */ "SBC addr,X",
    /* FE => */ "INC addr,X",
    /* FF => */ "SBC long,X",
}; // Opcodes

/**
 * Clock pin
 */
static byte const PHI2 = 2;

/**
 * executed at every clock pulse of the monitored 6502
 */
static void On_Clock ();

/**
 * VIA read/write pin. (read high, write low)
 */
static byte const RWB = 3;

/**
 * RDY (Ready) CPU ready. Low when the CPU has stopped after
 * executing. either STP or WAI instructions. Note that this
 * is a bidirectional signal which can also be used to halt
 * the CPU.
 */
static byte const RDY = 4;

/**
 * SNYC (Synchronize with OpCode fetch). HIGH when the CPU
 * fetches an opcode
 */
static byte const SYNC = 5;

/**
 * Setup Arduino
 */
extern void setup ()
{
    Serial.begin (115200);
    Serial.println ();
    Serial.println ("Start 6502 Monitor (with Disassembler)");

    // Setup address bus pins
    //
    A.Init ();

    // Setup data bus pins
    //
    D.Init ();

    // Setup clock pin
    //
    pinMode (PHI2, INPUT);
    attachInterrupt (digitalPinToInterrupt (PHI2), On_Clock, RISING);

    // Setup read/write pin
    //
    pinMode (RWB, INPUT);

    return;
} // setup

/**
 * nothing to loop.
 */
extern void loop ()
{
    // do nothing

    return;
} // loop

/**
 * executed at every clock pulse of the monitored 6502.
 */
static void On_Clock ()
{
    auto Address = A.Read ();
    auto Data = D.Read ();
    auto Read_Write = digitalRead (RWB) == HIGH;
    auto Sync = digitalRead (SYNC) == HIGH;
    auto Ready = digitalRead (RDY) == HIGH;
    auto Read_Write_Char = Read_Write ? 'r' : 'W';  // read        / write
    auto Sync_Char = Sync ? 'I' : 'd';              // instruction / data
    auto Ready_Char = Ready ? 'e' : 'S';            // executing   / stop
    char Output[64];

    if (!Ready)
    {
        snprintf (
            Output,
            sizeof Output,
            "%04x %c %c %c %02x CPU Stopped",
            Address,
            Read_Write_Char,
            Ready_Char,
            Sync_Char,
            Data);
    }
    else if (Sync)
    {
        auto Opcode = Opcodes[Data];

        snprintf (
            Output,
            sizeof Output,
            "%04x %c %c %c %02x %s",
            Address,
            Read_Write_Char,
            Ready_Char,
            Sync_Char,
            Data,
            Opcode.c_str ());
    }
    else if (32 <= Data && Data < 127)
    {
        char Data_Char = Data;

        snprintf (
            Output,
            sizeof Output,
            "%04x %c %c %c %02x '%c'",
            Address,
            Read_Write_Char,
            Ready_Char,
            Sync_Char,
            Data,
            Data_Char);
    }
    else
    {
        snprintf (
            Output,
            sizeof Output,
            "%04x %c %c %c %02x",
            Address,
            Read_Write_Char,
            Ready_Char,
            Sync_Char,
            Data);
    } // if

    Serial.println (Output);

    return;
} // On_Clock

/*********************************************************** {{{1 **********/
/* vim: set nowrap tabstop=8 shiftwidth=2 softtabstop=2 expandtab : */
/* vim: set textwidth=0 filetype=arduino foldmethod=marker nospell : */
/* vim: set spell spelllang=en_gb : */
