{
    $Id: ppheap.pas,v 1.1.1.1 2001-07-23 17:16:50 memson Exp $
    Copyright (c) 1998-2000 by Pierre Muller

    Simple unit to add source line and column to each
    memory allocation made with heaptrc unit

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************}
unit ppheap;

  interface

    uses heaptrc;

    { call this function before any memory allocation
      in a unit initialization code (PM) }

    procedure pp_heap_init;

  implementation

    uses
       globtype,globals,files;

    procedure ppextra_info(p : pointer);
      var pl : plongint;
      begin
         longint(p^):=aktfilepos.line;
         pl:=plongint(cardinal(p)+4);
         pl^:=aktfilepos.column;
         pl:=plongint(cardinal(p)+8);
         if assigned(current_module) then
          pl^:=current_module^.unit_index*100000+aktfilepos.fileindex
         else
          pl^:=aktfilepos.fileindex
      end;

  const
     pp_heap_inited : boolean = false;

  procedure pp_heap_init;
    begin
       if not pp_heap_inited then
         begin
            setheaptraceoutput('heap.log');
{$ifndef TP}
            SetExtraInfo(12,@ppextra_info);
{$else TP}
            SetExtraInfo(12,ppextra_info);
{$endif TP}
         end;
       pp_heap_inited:=true;
    end;

  begin
     pp_heap_init;
  end.

{
  $Log: not supported by cvs2svn $
  Revision 1.10  2000/02/09 13:22:59  peter
    * log truncated

  Revision 1.9  2000/01/07 01:14:30  peter
    * updated copyright to 2000

  Revision 1.8  1999/11/17 17:05:02  pierre
   * Notes/hints changes

}

