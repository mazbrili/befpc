{
    $Id: export.pas,v 1.1.1.1 2001-07-23 17:16:22 memson Exp $
    Copyright (c) 1998-2000 by Florian Klaempfl

    This unit implements an uniform export object

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

 ****************************************************************************
}
unit export;

interface

uses
  cobjects{$IFDEF NEWST},objects{$ENDIF NEWST},symtable;

const
   { export options }
   eo_resident = $1;
   eo_index    = $2;
   eo_name     = $4;

type
   pexported_item = ^texported_item;
   texported_item = object(tlinkedlist_item)
      sym : psym;
      index : longint;
      name : pstring;
      options : word;
      is_var : boolean;
      constructor init;
      destructor done;virtual;
   end;

   pexportlib=^texportlib;
   texportlib=object
   private
      notsupmsg : boolean;
      procedure NotSupported;
   public
      constructor Init;
      destructor Done;
      procedure preparelib(const s : string);virtual;
      procedure exportprocedure(hp : pexported_item);virtual;
      procedure exportvar(hp : pexported_item);virtual;
      procedure generatelib;virtual;
   end;

var
   exportlib : pexportlib;

procedure InitExport;
procedure DoneExport;

implementation

uses
  systems,verbose,globals,files
{$ifdef i386}
  {$ifndef NOTARGETLINUX}
    ,t_linux
  {$endif}
  {$ifndef NOTARGETOS2}
    ,t_os2
  {$endif}
  {$ifndef NOTARGETWIN32}
    ,t_win32
  {$endif}
  {$ifndef NOTARGETBEOS}
    ,t_beos
  {$endif}
  {$ifndef NOTARGETGO32V2}
    ,t_go32v2
  {$endif}
{$endif}
{$ifdef m68k}
  {$ifndef NOTARGETLINUX}
    ,t_linux
  {$endif}
{$endif}
{$ifdef powerpc}
  {$ifndef NOTARGETLINUX}
    ,t_linux
  {$endif}
{$endif}
{$ifdef alpha}
  {$ifndef NOTARGETLINUX}
    ,t_linux
  {$endif}
{$endif}
  ;

{****************************************************************************
                           TImported_procedure
****************************************************************************}

constructor texported_item.init;
begin
  inherited init;
  sym:=nil;
  index:=-1;
  name:=nil;
  options:=0;
  is_var:=false;
end;


destructor texported_item.done;
begin
  stringdispose(name);
  inherited done;
end;


{****************************************************************************
                              TImportLib
****************************************************************************}

constructor texportlib.Init;
begin
  notsupmsg:=false;
end;


destructor texportlib.Done;
begin
end;


procedure texportlib.NotSupported;
begin
  { show the message only once }
  if not notsupmsg then
   begin
     Message(exec_e_dll_not_supported);
     notsupmsg:=true;
   end;
end;


procedure texportlib.preparelib(const s:string);
begin
  NotSupported;
end;


procedure texportlib.exportprocedure(hp : pexported_item);
begin
  NotSupported;
end;


procedure texportlib.exportvar(hp : pexported_item);
begin
  NotSupported;
end;


procedure texportlib.generatelib;
begin
  NotSupported;
end;


procedure DoneExport;
begin
  if assigned(exportlib) then
    dispose(exportlib,done);
end;


procedure InitExport;
begin
  case target_info.target of
{$ifdef i386}
    target_i386_Linux :
      exportlib:=new(pexportliblinux,Init);
    target_i386_Win32 :
      exportlib:=new(pexportlibwin32,Init);
    target_i386_BeOS :
      exportlib:=new(pexportlibbeos,Init);
{
    target_i386_OS2 :
      exportlib:=new(pexportlibos2,Init);
}
{$endif i386}
{$ifdef m68k}
    target_m68k_Linux :
      exportlib:=new(pexportlib,Init);
{$endif m68k}
{$ifdef alpha}
    target_alpha_Linux :
      exportlib:=new(pexportlib,Init);
{$endif alpha}
{$ifdef powerpc}
    target_alpha_Linux :
      exportlib:=new(pexportlib,Init);
{$endif powerpc}
    else
      exportlib:=new(pexportlib,Init);
  end;
end;


end.
{
  $Log: not supported by cvs2svn $
  Revision 1.12  2000/02/28 17:23:56  daniel
  * Current work of symtable integration committed. The symtable can be
    activated by defining 'newst', but doesn't compile yet. Changes in type
    checking and oop are completed. What is left is to write a new
    symtablestack and adapt the parser to use it.

  Revision 1.11  2000/02/09 13:22:52  peter
    * log truncated

  Revision 1.10  2000/01/12 10:34:29  peter
    * only give unsupported error once

  Revision 1.9  2000/01/07 01:14:27  peter
    * updated copyright to 2000

  Revision 1.8  1999/11/06 14:34:20  peter
    * truncated log to 20 revs

  Revision 1.7  1999/10/21 14:29:34  peter
    * redesigned linker object
    + library support for linux (only procedures can be exported)

  Revision 1.6  1999/08/04 13:02:41  jonas
    * all tokens now start with an underscore
    * PowerPC compiles!!

  Revision 1.5  1999/08/03 17:09:34  florian
    * the alpha compiler can be compiled now

}
