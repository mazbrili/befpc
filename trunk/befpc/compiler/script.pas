{
    $Id: script.pas,v 1.1.1.1 2001-07-23 17:17:02 memson Exp $
    Copyright (c) 1998-2000 by Peter Vreman

    This unit handles the writing of script files

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
unit Script;
interface

uses
  CObjects;

type
  PScript=^TScript;
  TScript=object
    fn   : string[80];
    data : TStringQueue;
    executable : boolean;
    constructor Init(const s:string);
    constructor InitExec(const s:string);
    destructor Done;
    procedure AddStart(const s:string);
    procedure Add(const s:string);
    Function  Empty:boolean;
    procedure WriteToDisk;virtual;
  end;

  PAsmScript = ^TAsmScript;
  TAsmScript = Object (TScript)
    Constructor Init (Const ScriptName : String);
    Procedure AddAsmCommand (Const Command, Options,FileName : String);
    Procedure AddLinkCommand (Const Command, Options, FileName : String);
    Procedure AddDeleteCommand (Const FileName : String);
    Procedure WriteToDisk;virtual;
  end;

  PLinkRes = ^TLinkRes;
  TLinkRes = Object (TScript)
    procedure Add(const s:string);
    procedure AddFileName(const s:string);
  end;

var
  AsmRes : TAsmScript;
  LinkRes : TLinkRes;


implementation

uses
{$ifdef linux}
  linux,
{$endif}

  globals,systems;


{$ifdef beos}
  {$define linux}
{$endif}


{****************************************************************************
                                  TScript
****************************************************************************}

constructor TScript.Init(const s:string);
begin
  fn:=FixFileName(s);
  executable:=false;
  data.Init;
end;


constructor TScript.InitExec(const s:string);
begin
  fn:=FixFileName(s)+source_os.scriptext;
  executable:=true;
  data.Init;
end;


destructor TScript.Done;
begin
  data.done;
end;


procedure TScript.AddStart(const s:string);
begin
  data.Insert(s);
end;


procedure TScript.Add(const s:string);
begin
  data.Concat(s);
end;


Function TScript.Empty:boolean;
begin
  Empty:=Data.Empty;
end;


procedure TScript.WriteToDisk;
var
  t : Text;
begin
  Assign(t,fn);
  Rewrite(t);
  while not data.Empty do
   Writeln(t,data.Get);
  Close(t);
{$ifdef linux}
 {$ifndef beos}
  if executable then
   ChMod(fn,493);
 {$endif}
{$endif}
end;


{****************************************************************************
                                  Asm Response
****************************************************************************}

Constructor TAsmScript.Init (Const ScriptName : String);
begin
  Inherited InitExec(ScriptName);
end;


Procedure TAsmScript.AddAsmCommand (Const Command, Options,FileName : String);
begin
  {$ifdef linux}
  if FileName<>'' then
   Add('echo Assembling '+FileName);
  Add (Command+' '+Options);
  Add('if [ $? != 0 ]; then DoExitAsm '+FileName+'; fi');
  {$else}
  if FileName<>'' then
   begin
     Add('SET THEFILE='+FileName);
     Add('echo Assembling %THEFILE%');
   end;
  Add(command+' '+Options);
  Add('if errorlevel 1 goto asmend');
  {$endif}
end;


Procedure TasmScript.AddLinkCommand (Const Command, Options, FileName : String);
begin
  {$ifdef linux}
  if FileName<>'' then
   Add('echo Linking '+FileName);
  Add (Command+' '+Options);
  Add('if [ $? != 0 ]; then DoExitLink '+FileName+'; fi');
  {$else}
  if FileName<>'' then
   begin
     Add('SET THEFILE='+FileName);
     Add('echo Linking %THEFILE%');
   end;
  Add (Command+' '+Options);
  Add('if errorlevel 1 goto linkend');
  {$endif}
end;


Procedure TAsmScript.AddDeleteCommand (Const FileName : String);
begin
 {$ifdef linux}
 Add('rm '+FileName);
 {$else}
 Add('Del '+FileName);
 {$endif}
end;


Procedure TAsmScript.WriteToDisk;
Begin
{$ifdef linux}
  AddStart('{ echo "An error occurred while linking $1"; exit 1; }');
  AddStart('DoExitLink ()');
  AddStart('{ echo "An error occurred while assembling $1"; exit 1; }');
  AddStart('DoExitAsm ()');
  AddStart('#!/bin/sh');
{$else}
  AddStart('@echo off');
  Add('goto end');
  Add(':asmend');
  Add('echo An error occured while assembling %THEFILE%');
  Add('goto end');
  Add(':linkend');
  Add('echo An error occured while linking %THEFILE%');
  Add(':end');
{$endif}
  inherited WriteToDisk;
end;


{****************************************************************************
                                  Link Response
****************************************************************************}

procedure TLinkRes.Add(const s:string);
begin
  if s<>'' then
   inherited Add(s);
end;

procedure TLinkRes.AddFileName(const s:string);
begin
  if s<>'' then
   begin
     if not(s[1] in ['a'..'z','A'..'Z','/','\','.']) then
      inherited Add('.'+DirSep+s)
     else
      inherited Add(s);
   end;
end;

end.
{
  $Log: not supported by cvs2svn $
  Revision 1.6  2000/02/09 13:23:04  peter
    * log truncated

  Revision 1.5  2000/02/07 11:52:26  michael
  + Changed bash to sh

  Revision 1.4  2000/01/07 01:14:39  peter
    * updated copyright to 2000

  Revision 1.3  1999/10/21 14:29:37  peter
    * redesigned linker object
    + library support for linux (only procedures can be exported)

}
