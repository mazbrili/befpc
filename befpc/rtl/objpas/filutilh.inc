{
    $Id: filutilh.inc,v 1.1.1.1 2001-07-23 17:17:41 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    File utility calls
    
    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

Type 
  THandle = Longint; 

Type 
  TSearchRec = Record
    Time,Size, Attr : Longint;
    Name : TFileName;
    ExcludeAttr : Longint;
    FindHandle : THandle;
    {$ifdef Win32}
    FindData : TWin32FindData;        
    {$endif}
    end;

Const 
  { File attributes }
  faReadOnly  = $00000001; 
  faHidden    = $00000002;
  faSysFile   = $00000004;
  faVolumeId  = $00000008;
  faDirectory = $00000010;
  faArchive   = $00000020;
  faAnyFile   = $0000003f;
  
  { File open modes }
  fmOpenRead       = $0000;
  fmOpenWrite      = $0001;
  fmOpenReadWrite  = $0002;
  
  { File seek origins }    
  fsFromBeginning = 0;
  fsFromCurrent   = 1;
  fsFromEnd       = 2;
    
Function FileOpen (Const FileName : string; Mode : Integer) : Longint;
Function FileCreate (Const FileName : String) : Longint;
Function FileRead (Handle : Longint; Var Buffer; Count : longint) : Longint;
Function FileWrite (Handle : Longint; const Buffer; Count : Longint) : Longint;
Function FileSeek (Handle,FOffset,Origin : Longint) : Longint;
Procedure FileClose (Handle : Longint);
Function FileTruncate (Handle,Size: Longint) : boolean;
Function FileAge (Const FileName : String): Longint;
Function FileExists (Const FileName : String) : Boolean;
Function FindFirst (Const Path : String; Attr : Longint; Var Rslt : TSearchRec) : Longint;
Function FindNext (Var Rslt : TSearchRec) : Longint;
Procedure FindClose (Var F : TSearchrec);
Function FileGetDate (Handle : Longint) : Longint;
Function FileSetDate (Handle,Age : Longint) : Longint;
Function FileGetAttr (Const FileName : String) : Longint;
Function FileSetAttr (Const Filename : String; Attr: longint) : Longint;
Function DeleteFile (Const FileName : String) : Boolean;
Function RenameFile (Const OldName, NewName : String) : Boolean;
Function FileSearch (Const Name, DirList : String) : String;


{
  $Log: not supported by cvs2svn $
  Revision 1.9  2000/06/04 14:22:15  hajny
    * parameter name change in FileSeek

  Revision 1.8  2000/02/17 22:16:05  sg
  * Changed the second argument of FileWrite from "var buffer" to
    "const buffer", like in Delphi.

  Revision 1.7  2000/02/09 16:59:32  peter
    * truncated log

  Revision 1.6  2000/01/07 16:41:43  daniel
    * copyright 2000

}
