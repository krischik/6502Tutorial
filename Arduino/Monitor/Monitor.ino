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

// Address bus pins
//
static const byte A[] = {
  22, 24, 26, 28, 30, 32, 34, 36,
  38, 40, 42, 44, 46, 48, 50, 52
};

// Data bus pins
//
static const byte D[] = {
  39, 41, 43, 45, 47, 49, 51, 53
};

// Clock pin
//
static const byte PHI2 = 2;
static void onClock ();

// Read/Write pin
//
static const byte RWB = 3;

void setup ()
{
  Serial.begin (115200);

  // Setup address bus pins
  //
  for (unsigned int i = 0; i < sizeof A; i++)
  {
    pinMode (A[i], INPUT);
  } // for

  // Setup data bus pins 
  //
  for (unsigned int i = 0; i < sizeof D; i++)
  {
    pinMode (D[i], INPUT);
  } // for

  // Setup plock pin
  //
  pinMode (PHI2, INPUT);
  attachInterrupt (digitalPinToInterrupt (PHI2), onClock, RISING);

  // Setup read/write puin
  pinMode (RWB, INPUT);
  
} // setup

void loop()
{
  // do nothing
} // loop

void onClock ()
{
  word Address = 0;
  for (unsigned int i = 0; i < sizeof A; i++)
  {
    auto bit = digitalRead (A[i]) == HIGH ? 1 : 0;

    Serial.print (bit);

    Address = (Address << 1) + bit;
  } // for

  Serial.print ("  ");

  byte Data = 0;
  for (unsigned int i = 0; i < sizeof D; i++)
  {
    auto bit = digitalRead (D[i]) == HIGH ? 1 : 0;

    Serial.print (bit);

    Data = (Data << 1) + bit;
  } // for

  auto Read_Write = digitalRead (RWB) == HIGH ? 'r' : 'W';

  char output [15];
  snprintf (output, sizeof output, "  %04x %c %02x", Address, Read_Write, Data);
  Serial.println (output);
} // onClock

/*********************************************************** {{{1 **********/
/* vim: set nowrap tabstop=8 shiftwidth=2 softtabstop=2 expandtab : */
/* vim: set textwidth=0 filetype=arduino foldmethod=marker nospell : */
