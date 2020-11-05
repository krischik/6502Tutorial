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

procedure Create_NOP is

   package Byte_IO is new Ada.Sequential_IO (Interfaces.Unsigned_8);

   Byte_Output : Byte_IO.File_Type;
   NOP         : constant Interfaces.Unsigned_8 := 16#EA#;
   Rom_Size    : constant                       := 32 * 2**10;

begin
   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line ("Syntax: create_nop <output file>");
   else
      declare
         File_Name : constant String := Ada.Command_Line.Argument (1);
      begin
         Byte_IO.Create (Byte_Output, Byte_IO.Out_File, File_Name);
      exception
         when Ada.IO_Exceptions.Name_Error =>
            Ada.Text_IO.Put_Line ("File “" & File_Name & "” couldn't be created.");
            Ada.Text_IO.Put_Line ("See stack trace below for more details.");
            raise;
      end;

      for I in 1 .. Rom_Size loop
         Byte_IO.Write (Byte_Output, NOP);
      end loop;

      Byte_IO.Close (Byte_Output);
   end if;
end Create_NOP;

-------------------------------------------------------------------------------
--  vim: set nowrap tabstop=8 shiftwidth=3 softtabstop=3 expandtab : vim: set
--  textwidth=0 filetype=ada foldmethod=expr nospell :
