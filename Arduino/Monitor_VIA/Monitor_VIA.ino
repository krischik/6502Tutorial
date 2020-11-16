/*********************************************************** {{{1 ***********
   Copyright © 2020 … 2020 Martin Krischik «krischik@users.sourceforge.net»
*****************************************************************************
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see «http://www.gnu.org/licenses/».
************************************************************* }}}1 *********/

#include <USBAPI.h>

/**
 * Bus class handles reading the 6050 address and data bus
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
};

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

/**
 * Clock pin
 */
static byte const PHI2 = 2;

/**
 * executed at every clock pulse of the monitored 6502
 */
static void On_Clock ();

/**
 * Read/Write pin
 */
static byte const RWB = 3;

/**
 * Read/Write pin
 */
static byte const CS1 = 4;

/**
 * Read/Write pin
 */
static byte const CS2B = 5;


/**
 * Setup Arduino
 */
extern void setup ()
{
    Serial.begin (115200);
    Serial.println ();
    Serial.println ("Start 6502 Monitor");

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

extern void loop ()
{
    // do nothing

    return;
} // loop

/**
 * executed at every clock pulse of the monitored 6502
 */
static void On_Clock ()
{
    auto Address = A.Read ();
    auto Data = D.Read ();
    auto Read_Write    = digitalRead (RWB)  == HIGH ? 'r' : 'W';
    auto Chip_Enable_1 = digitalRead (CS1)  == HIGH ? 'E' : 'd';
    auto Chip_Enable_2 = digitalRead (CS2B) == LOW  ? 'E' : 'D';
    char Output[15];

    snprintf (
      Output,
      sizeof Output,
      "%04x %c %c %c %02x",
      Address,
      Read_Write,
      Chip_Enable_1,
      Chip_Enable_2,
      Data);
    Serial.println (Output);

    return;
} // On_Clock

/*********************************************************** {{{1 **********/
/* vim: set nowrap tabstop=8 shiftwidth=2 softtabstop=2 expandtab : */
/* vim: set textwidth=0 filetype=arduino foldmethod=marker nospell : */
/* vim: set spell spelllang=en_gb : */
