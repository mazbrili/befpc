{
    *********************************************************************
    $Id: fina.inc,v 1.1.1.1 2001-07-23 17:17:41 memson Exp $
    Copyright (C) 1997, 1998 Gertjan Schouten

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
    *********************************************************************

    System Utilities For Free Pascal
}

function ChangeFileExt(const FileName, Extension: string): string;
var i: longint;
begin
I := Length(FileName);
while (I > 0) and not(FileName[I] in ['/', '.', '\', ':']) do Dec(I);
if (I = 0) or (FileName[I] <> '.') then I := 255;
Result := Copy(FileName, 1, I - 1) + Extension;
end;

function ExtractFilePath(const FileName: string): string;
var i: longint;
begin
i := Length(FileName);
while (i > 0) and not (FileName[i] in ['/', '\', ':']) do Dec(i);
If I>0 then
  Result := Copy(FileName, 1, i)
else
  Result:='';
end;

function ExtractFileDir(const FileName: string): string;
var i: longint;
begin
I := Length(FileName);
while (I > 0) and not (FileName[I] in ['/', '\', ':']) do Dec(I);
if (I > 1) and (FileName[I] in ['\', '/']) and
   not (FileName[I - 1] in ['/', '\', ':']) then Dec(I);
Result := Copy(FileName, 1, I);
end;

function ExtractFileDrive(const FileName: string): string;
var i: longint;
begin
if (Length(FileName) >= 3) and (FileName[2] = ':') then
   result := Copy(FileName, 1, 2)
else if (Length(FileName) >= 2) and (FileName[1] in ['/', '\']) and
   (FileName[2] in ['/', '\']) then begin
   i := 2;
   While (i < Length(Filename)) do begin
           if Filename[i + 1] in ['/', '\'] then break;
      inc(i);
      end ;
   Result := Copy(FileName, 1, i);
   end
else Result := '';
end;

function ExtractFileName(const FileName: string): string;
var i: longint;
begin
I := Length(FileName);
while (I > 0) and not (FileName[I] in ['/', '\', ':']) do Dec(I);
Result := Copy(FileName, I + 1, 255);
end;

function ExtractFileExt(const FileName: string): string;
var i: longint;
begin
I := Length(FileName);
while (I > 0) and not (FileName[I] in ['.', '/', '\', ':']) do Dec(I);
if (I > 0) and (FileName[I] = '.') then
   Result := Copy(FileName, I, 255)
else Result := '';
end;

function ExpandFileName (Const FileName : string): String;

Var S : String;

Begin
 S:=FileName;
 DoDirSeparators(S);
{$ifdef linux}
  Result:=Linux.fexpand(S);
{$else}
  Result:=Dos.Fexpand(S);
{$endif}
end;

function ExpandUNCFileName (Const FileName : string): String;
begin
  Result:=ExpandFileName (FileName);
  //!! Here should follow code to replace the drive: part with UNC...
end;

Const MaxDirs = 129;

function ExtractRelativepath (Const BaseName,DestName : String): String;

Var Source, Dest : String;
    Sc,Dc,I,J    : Longint;
    SD,DD        : Array[1..MaxDirs] of PChar;

Const OneLevelBack = '..'+OSDirSeparator;

begin
  If Upcase(ExtractFileDrive(BaseName))<>Upcase(ExtractFileDrive(DestName)) Then
    begin
    Result:=DestName;
    exit;
    end;
  Source:=ExtractFilePath(BaseName);
  Dest:=ExtractFilePath(DestName);
  SC:=GetDirs (Source,SD);
  DC:=GetDirs (Dest,DD);
  I:=1;
  While (I<DC) and (I<SC) do
    begin
    If StrIcomp(DD[i],SD[i])=0 then
      Inc(i)
    else
      Break;
    end;
  Result:='';
  For J:=I to SC-1 do Result:=Result+OneLevelBack;
  For J:=I to DC-1 do Result:=Result+DD[J]+OsDirSeparator;
  Result:=Result+ExtractFileName(DestNAme);
end;

Procedure DoDirSeparators (Var FileName : String);

VAr I : longint;

begin
  For I:=1 to Length(FileName) do
    If FileName[I] in DirSeparators then
      FileName[i]:=OSDirSeparator;
end;


Function SetDirSeparators (Const FileName : string) : String;

begin
  Result:=FileName;
  DoDirSeparators (Result);
end;

{
  DirName is split in a #0 separated list of directory names,
  Dirs is an array of pchars, pointing to these directory names.
  The function returns the number of directories found, or -1
  if none were found.
  DirName must contain only OSDirSeparator as Directory separator chars.
}

Function GetDirs (Var DirName : String; Var Dirs : Array of pchar) : Longint;

Var I : Longint;

begin
  I:=1;
  Result:=-1;
  While I<=Length(DirName) do
    begin
    If DirName[i]=OsDirSeparator then
      begin
      DirName[i]:=#0;
      Inc(Result);
      Dirs[Result]:=@DirName[I+1];
      end;
    Inc(I);
    end;
  If Result>-1 then inc(Result);
end;

{
  $Log: not supported by cvs2svn $
  Revision 1.7  2000/02/09 16:59:32  peter
    * truncated log

}
