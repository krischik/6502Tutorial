-------------------------------------------------------------------------------
--  Copyright © 2020 … 2020 Martin Krischik «krischik@users.sourceforge.net»
-------------------------------------------------------------------------------
--  This library is free software; you can redistribute it and/or modify it
--  under the terms of the GNU Library General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or (at your
--  option) any later version.
--
--  This library is distributed in the hope that it will be useful, but WITHOUT
--  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
--  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public
--  License for more details.
--
--  You should have received a copy of the GNU Library General Public License
--  along with this library; if not, write to the Free Software Foundation,
--  Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-------------------------------------------------------------------------------

with Ada.Sequential_IO;
with Ada.IO_Exceptions;
with Ada.Command_Line;
with Ada.Text_IO;
with Interfaces;

procedure Create_Reset is

   type Byte is new Interfaces.Unsigned_8;
   type Address is new Interfaces.Unsigned_16;

  --  One of the cool feature of Ada is it's ability to set the lower and
  --  upper bound of an array to any value you want. So we can set use the
  --  actual ROM addresses as array index an save ourself the work and
  --  remove one potential error source.
  --
   type ROM_Type is
      array (Address range 16#8000# .. 16#FFFF#)
      of Byte;

   package ROM_IO is new Ada.Sequential_IO (ROM_Type);

   ROM_Output : ROM_IO.File_Type;

  --  65C02 related constants as named in the original
  --  WDC design document
  --
   NOP      : constant Byte    := 16#EA#;
   NMIB     : constant Address := 16#FFFA#;
   RESB     : constant Address := 16#FFFC#;
   BRK_IRQB : constant Address := 16#FFFE#;

  --  Another interesting feature Ada arrays is specifying the index of
  --  elements when initialising the array. As well specifying an value
  --  for all not explicitly initialised values. Makes setting up the
  --  ROM array super easy.
  --
   ROM : constant ROM_Type :=
      (NMIB + 0     => 16#00#,
       NMIB + 1     => 16#80#,
       RESB + 0     => 16#00#,
       RESB + 1     => 16#80#,
       BRK_IRQB + 0 => 16#00#,
       BRK_IRQB + 1 => 16#80#,
       others       => NOP);

begin
   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line ("Syntax: Create_Reset <output file>");
   else
      declare
         File_Name : constant String := Ada.Command_Line.Argument (1);
      begin
         ROM_IO.Create (ROM_Output, ROM_IO.Out_File, File_Name);
      exception
         when Ada.IO_Exceptions.Name_Error =>
            Ada.Text_IO.Put_Line ("File “" & File_Name & "” couldn't be created.");
            Ada.Text_IO.Put_Line ("See stack trace below for more details.");
            raise;
      end;

     --  Just like Python Ada can write the whole array in one go.
     --
      ROM_IO.Write (ROM_Output, ROM);
      ROM_IO.Close (ROM_Output);
   end if;
end Create_Reset;

-------------------------------------------------------------------------------
--  vim: set nowrap tabstop=8 shiftwidth=3 softtabstop=3 expandtab : vim: set
--  textwidth=0 filetype=ada foldmethod=expr :
--  vim: set spell spelllang=en_gb :
