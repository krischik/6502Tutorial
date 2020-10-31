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

/**
   Just testing if the Arduino, or better the
   keyestudio MEGA works and is propperly
   connected to the computer
*/
void setup()
{
  Serial.begin (115200);
  Serial.println ();
  Serial.print ("Hello World");
  Serial.println ();
}

/**
   nothing to loop.
*/
void loop()
{
}

/*********************************************************** {{{1 **********/
/* vim: set nowrap tabstop=8 shiftwidth=2 softtabstop=2 expandtab : */
/* vim: set textwidth=0 filetype=arduino foldmethod=marker nospell : */
