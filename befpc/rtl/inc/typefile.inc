{
    $Id: typefile.inc,v 1.1.1.1 2001-07-23 17:17:40 memson Exp $
    This file is part of the Free Pascal Run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    See the File COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{****************************************************************************
                    subroutines for typed file handling
****************************************************************************}

Procedure assign(var f:TypedFile;const Name:string);
{
  Assign Name to file f so it can be used with the file routines
}
Begin
  FillChar(f,SizeOF(FileRec),0);
  FileRec(f).Handle:=UnusedHandle;
  FileRec(f).mode:=fmClosed;
  Move(Name[1],FileRec(f).Name,Length(Name));
End;


Procedure assign(var f:TypedFile;p:pchar);
{
  Assign Name to file f so it can be used with the file routines
}
begin
  Assign(f,StrPas(p));
end;


Procedure assign(var f:TypedFile;c:char);
{
  Assign Name to file f so it can be used with the file routines
}
begin
  Assign(f,string(c));
end;


Procedure Int_Typed_Reset(var f : TypedFile;Size : Longint);[Public,IOCheck, Alias:'FPC_RESET_TYPED'];
Begin
  If InOutRes <> 0 then
   exit;
  Reset(UnTypedFile(f),Size);
End;


Procedure Int_Typed_Rewrite(var f : TypedFile;Size : Longint);[Public,IOCheck, Alias:'FPC_REWRITE_TYPED'];
Begin
  If InOutRes <> 0 then
   exit;
  Rewrite(UnTypedFile(f),Size);
End;


Procedure Int_Typed_Write(TypeSize : Longint;var f : TypedFile;var Buf);[IOCheck, Public, Alias :'FPC_TYPED_WRITE'];
Begin
  If InOutRes <> 0 then
   exit;
  case fileRec(f).mode of
    fmOutPut,fmInOut:
      Do_Write(FileRec(f).Handle,Longint(@Buf),TypeSize);
    fmInput: inOutRes := 105;
    else inOutRes := 103;
  end;
End;

Procedure Int_Typed_Read(TypeSize : Longint;var f : TypedFile;var Buf);[IOCheck, Public, Alias :'FPC_TYPED_READ'];
var
  Result : Longint;
Begin
  If InOutRes <> 0 then
   exit;
  case FileRec(f).mode of
    fmInput,fmInOut:
      begin
        Result:=Do_Read(FileRec(f).Handle,Longint(@Buf),TypeSize);
        If Result<TypeSize Then
         InOutRes:=100
      end;
    fmOutPut: inOutRes := 104
    else inOutRes := 103;
  end;
End;

{
  $Log: not supported by cvs2svn $
  Revision 1.10  2000/03/24 10:26:19  jonas
    * changed a lot of "if fm.mode = fmClosed then" to case statements,
      because if f is not yet initialized, the mode is invalid and can
      contain another value even though the file is closed
    + check if a file is open in writeln_end (caused crash if used on
      not opened files)

  Revision 1.9  2000/02/09 16:59:31  peter
    * truncated log

  Revision 1.8  2000/01/07 16:41:37  daniel
    * copyright 2000

  Revision 1.7  2000/01/07 16:32:25  daniel
    * copyright 2000 added

}
