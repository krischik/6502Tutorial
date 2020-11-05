----------------------------------------------------------------------------
--  Copyright © 2020 … 2020  Martin Krischik «krischik@users.sourceforge.net»
----------------------------------------------------------------------------
--
--  This library is free software; you can redistribute it and/or
--  modify it under the terms of the GNU Library General Public
--  License as published by the Free Software Foundation; either
--  version 2 of the License, or (at your option) any later version.
--
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  Library General Public License for more details.
--
--  You should have received a copy of the GNU Library General Public
--  License along with this library; if not, write to the Free
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
----------------------------------------------------------------------------

with Ada.Sequential_IO;
with Ada.IO_Exceptions;
with Ada.Text_IO;
with Interfaces;

procedure CreateNOP is

   package IO is new Ada.Sequential_IO (Interfaces.Unsigned_8);

   Byte_Output : IO.File_Type;

begin
   begin
      IO.Open (
         File => Byte_Output,
         Mode => IO.Out_File,
         Name => "NOP.rom");
   exception
      when Ada.IO_Exceptions.Name_Error  =>
         Ada.Text_IO.Put_Line ("File 'NOP.rom' not created");
         return;
   end;

   IO.Close (Byte_Output);
end CreateNOP;
