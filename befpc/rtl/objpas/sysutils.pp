{
    $Id: sysutils.pp,v 1.1.1.1 2001-07-23 17:17:43 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Florian Klaempfl
    member of the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit sysutils;
interface

{$MODE objfpc}
{ force ansistrings }
{$H+}

    uses
    {$ifdef linux}
       linux
    {$endif}
    {$ifdef win32}
       dos,windows
    {$endif}
    {$ifdef go32v1}
       go32,dos
    {$endif}
    {$ifdef go32v2}
       go32,dos
    {$endif}
    {$ifdef os2}
       doscalls,dos
    {$endif}
       ;


type
   { some helpful data types }

   tprocedure = procedure;

   tfilename = string;

   tsyscharset = set of char;

   longrec = packed record
      lo,hi : word;
   end;

   wordrec = packed record
      lo,hi : byte;
   end;

   TMethod = packed record
     Code, Data: Pointer;
   end;


   { exceptions }
   exception = class(TObject)
    private
      fmessage : string;
      fhelpcontext : longint;
    public
      constructor create(const msg : string);
      constructor createfmt(const msg : string; const args : array of const);
      constructor createres(ident : longint);
      { !!!! }
      property helpcontext : longint read fhelpcontext write fhelpcontext;
      property message : string read fmessage write fmessage;
   end;

   exceptclass = class of exception;

   { integer math exceptions }
   EInterror    = Class(Exception);
   EDivByZero   = Class(EIntError);
   ERangeError  = Class(EIntError);
   EIntOverflow = Class(EIntError);

   { General math errors }
   EMathError  = Class(Exception);
   EInvalidOp  = Class(EMathError);
   EZeroDivide = Class(EMathError);
   EOverflow   = Class(EMathError);
   EUnderflow  = Class(EMathError);

   { Run-time and I/O Errors }
   EInOutError = class(Exception)
     public
     ErrorCode : Longint;
     end;
   EInvalidPointer  = Class(Exception);
   EOutOfMemory     = Class(Exception);
   EAccessViolation = Class(Exception);
   EInvalidCast = Class(Exception);


   { String conversion errors }
   EConvertError = class(Exception);

   { Other errors }
   EAbort           = Class(Exception);
   EAbstractError   = Class(Exception);
   EAssertionFailed = Class(Exception);

   { Exception handling routines }
   function ExceptObject: TObject;
   function ExceptAddr: Pointer;
   function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
                                  Buffer: PChar; Size: Integer): Integer;
   procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);
   procedure Abort;
   procedure OutOfMemoryError;
   procedure Beep;

Var
   OnShowException : Procedure (Msg : ShortString);

  { FileRec/TextRec }
  {$i filerec.inc}
  {$i textrec.inc}

  { Read internationalization settings }
  {$i sysinth.inc}

  { Read date & Time function declarations }
  {$i datih.inc}

  { Read String Handling functions declaration }
  {$i sysstrh.inc}

  { Read pchar handling functions declration }
  {$i syspchh.inc}

  { Read filename handling functions declaration }
  {$i finah.inc}

  { Read other file handling function declarations }
  {$i filutilh.inc}

  { Read disk function declarations }
  {$i diskh.inc}

  implementation

  { Read message string definitions }
  {
   Add a language with IFDEF LANG_NAME
   just befor the final ELSE. This way English will always be the default.
  }

  {$IFDEF LANG_GERMAN}
  {$i strg.inc} // Does not exist yet !!
  {$ELSE}
  {$i stre.inc}
  {$ENDIF}

  { Read filename handling functions implementation }
  {$i fina.inc}

  { Read String Handling functions implementation }
  {$i sysstr.inc}

  { Read other file handling function implementations }
  {$i filutil.inc}

  { Read disk function implementations }
  {$i disk.inc}

  { Read date & Time function implementations }
  {$i dati.inc}

  { Read pchar handling functions implementation }
  {$i syspch.inc}


    constructor exception.create(const msg : string);

      begin
         inherited create;
         fmessage:=msg;
      end;


    constructor exception.createfmt(const msg : string; const args : array of const);

      begin
         inherited create;
         fmessage:=Format(msg,args);
      end;


    constructor exception.createres(ident : longint);

      begin
         inherited create;
         {!!!!!}
      end;


{$ifopt S+}
{$define STACKCHECK_WAS_ON}
{$S-}
{$endif OPT S }
Procedure CatchUnhandledException (Obj : TObject; Addr,Frame: Pointer);
Var
  Message : String;
begin
  Writeln(stdout,'An unhandled exception occurred at 0x',HexStr(Longint(Addr),8),' :');
  if Obj is exception then
   begin
     Message:=Exception(Obj).Message;
     Writeln(stdout,Message);
   end
  else
   Writeln(stdout,'Exception object ',Obj.ClassName,' is not of class Exception.');
  { to get a nice symify }
  Writeln(stdout,BackTraceStrFunc(Longint(Addr)));
  Dump_Stack(stdout,longint(frame));
  Writeln(stdout,'');
  Halt(217);
end;


Var OutOfMemory : EOutOfMemory;
    InValidPointer : EInvalidPointer;


Procedure RunErrorToExcept (ErrNo : Longint; Address,Frame : Pointer);

Var E : Exception;
    S : String;

begin
  Case Errno of
   1,203 : E:=OutOfMemory;
   204 : E:=InvalidPointer;
   2,3,4,5,6,100,101,102,103,105,106 : { I/O errors }
     begin
     Case Errno of
       2 : S:=SFileNotFound;
       3 : S:=SInvalidFileName;
       4 : S:=STooManyOpenFiles;
       5 : S:=SAccessDenied;
       6 : S:=SInvalidFileHandle;
       15 : S:=SInvalidDrive;
       100 : S:=SEndOfFile;
       101 : S:=SDiskFull;
       102 : S:=SFileNotAssigned;
       103 : S:=SFileNotOpen;
       104 : S:=SFileNotOpenForInput;
       105 : S:=SFileNotOpenForOutput;
       106 : S:=SInvalidInput;
     end;
     E:=EinOutError.Create (S);
     EInoutError(E).ErrorCode:=IOresult; // Clears InOutRes !!
     end;
  // We don't set abstracterrorhandler, but we do it here.
  // Unless the use sets another handler we'll get here anyway...
  200 : E:=EDivByZero.Create(SDivByZero);
  201 : E:=ERangeError.Create(SRangeError);
  205 : E:=EOverflow.Create(SOverflow);
  206 : E:=EOverflow.Create(SUnderflow);
  207 : E:=EInvalidOp.Create(SInvalidOp);
  211 : E:=EAbstractError.Create(SAbstractError);
  215 : E:=EIntOverflow.Create(SIntOverflow);
  216 : E:=EAccessViolation.Create(SAccessViolation);
  219 : E:=EInvalidCast.Create(SInvalidCast);
  227 : E:=EAssertionFailed.Create(SAssertionFailed);
  else
   E:=Exception.CreateFmt (SUnKnownRunTimeError,[Errno]);
  end;
  Raise E at longint(Address){$ifdef ENHANCEDRAISE},longint(Frame){$endif};
end;


Procedure AssertErrorHandler (Const Msg,FN : ShortString;LineNo,TheAddr : Longint);
Var
  S : String;
begin
  If Msg='' then
    S:=SAssertionFailed
  else
    S:=Msg;
  Raise EAssertionFailed.Createfmt(SAssertError,[S,Fn,LineNo]); // at Pointer(theAddr);
end;

{$ifdef STACKCHECK_WAS_ON}
{$S+}
{$endif}

Procedure InitExceptions;
{
  Must install uncaught exception handler (ExceptProc)
  and install exceptions for system exceptions or signals.
  (e.g: SIGSEGV -> ESegFault or so.)
}
begin
  ExceptProc:=@CatchUnhandledException;
  // Create objects that may have problems when there is no memory.
  OutOfMemory:=EOutOfMemory.Create(SOutOfMemory);
  InvalidPointer:=EInvalidPointer.Create(SInvalidPointer);
  AssertErrorProc:=@AssertErrorHandler;
  ErrorProc:=@RunErrorToExcept;
  OnShowException:=Nil;
end;

{ Exception handling routines }

function ExceptObject: TObject;

begin
  If RaiseList=Nil then
    Result:=Nil
  else
    Result:=RaiseList^.FObject;
end;

function ExceptAddr: Pointer;

begin
  If RaiseList=Nil then
    Result:=Nil
  else
    Result:=RaiseList^.Addr;
end;

function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
                               Buffer: PChar; Size: Integer): Integer;

Var
  S : AnsiString;
  Len : Integer;
  
begin
  S:=Format(SExceptionErrorMessage,[ExceptObject.ClassName,ExceptAddr]);
  If ExceptObject is Exception then
    S:=Format('%s:'#10'%s',[S,Exception(ExceptObject).Message]);
  Len:=Length(S);
  If S[Len]<>'.' then
    begin
    S:=S+'.';
    Inc(len);
    end;
  If Len>Size then
    Len:=Size;
  Move(S[1],Buffer^,Len);
  Result:=Len;
end;

procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);

// use shortstring. On exception, the heap may be corrupt.

Var
  Buf : ShortString;

begin
  SetLength(Buf,ExceptionErrorMessage(ExceptObject,ExceptAddr,@Buf[1],255));
  If IsConsole Then
    writeln(Buf)
  else
    If Assigned(OnShowException) Then
      OnShowException (Buf);
end;

procedure Abort;

begin
  Raise EAbort.Create(SAbortError) at Get_Caller_addr(Get_Frame)
end;

procedure OutOfMemoryError;

begin
  Raise OutOfMemory;
end;

procedure Beep;

begin
  {$ifdef win32}
  MessageBeep(0);
  {$else}
  
  {$endif}
end;

{  Initialization code. }

Initialization
  InitExceptions;       { Initialize exceptions. OS independent }
  InitInternational;    { Initialize internationalization settings }
Finalization
  OutOfMemory.Free;
  InValidPointer.Free;
end.
{
    $Log: not supported by cvs2svn $
    Revision 1.47  2000/06/22 18:05:18  michael
    + Added ExceptObject, ExceptAddr,ExceptionErrorMessage
       ShowException Abort; OutOfMemoryError; Beep;

    Revision 1.46  2000/06/11 07:07:23  peter
      + TSysCharSet

    Revision 1.45  2000/04/24 13:34:29  peter
      * added enhancedraise define

    Revision 1.43  2000/03/30 13:54:15  pierre
     No stack check inside CatchUnhandledException

    Revision 1.42  2000/02/10 22:56:43  florian
      * quick hack for stack trace in the case of an unhandled exception

    Revision 1.41  2000/02/09 16:59:33  peter
      * truncated log

    Revision 1.40  2000/01/16 19:10:25  hajny
      * 'uses Dos' added for OS/2 target

    Revision 1.39  2000/01/07 16:41:44  daniel
      * copyright 2000

    Revision 1.38  1999/12/26 19:30:53  hajny
      * OS/2 target added to the uses clause

    Revision 1.36  1999/11/15 21:49:47  peter
      * exception address fixes

    Revision 1.35  1999/11/06 14:41:31  peter
      * truncated log

    Revision 1.34  1999/10/30 17:39:05  peter
      * memorymanager expanded with allocmem/reallocmem

    Revision 1.33  1999/10/26 12:29:07  peter
      * assert handler must use shortstring

    Revision 1.32  1999/09/15 20:26:30  florian
      * patch from Sebastian Guenther applied: TMethod implementation

    Revision 1.31  1999/08/28 14:53:27  florian
      * bug 471 fixed: run time error 2 is now converted into a file not
        found exception

    Revision 1.30  1999/08/18 11:28:24  michael
    * Fixed reallocmem bug 535

    Revision 1.29  1999/07/27 13:01:12  peter
      + filerec,textrec declarations

}