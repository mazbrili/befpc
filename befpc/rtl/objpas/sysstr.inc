{
    *********************************************************************
    $Id: sysstr.inc,v 1.1.1.1 2001-07-23 17:17:43 memson Exp $
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

{   NewStr creates a new PString and assigns S to it
    if length(s) = 0 NewStr returns Nil   }

function NewStr(const S: string): PString;
begin
  if (S='') then
   Result:=nil
  else
   begin
     getmem(Result,length(s)+1);
     if (Result<>nil) then
      Result^:=s;
   end;
end;

{   DisposeStr frees the memory occupied by S   }

procedure DisposeStr(S: PString);
begin
  if S <> Nil then
   begin
     Freemem(S,Length(S^)+1);
     S:=nil;
   end;
end;

{   AssignStr assigns S to P^   }

procedure AssignStr(var P: PString; const S: string);
begin
  P^ := s;
end ;

{   AppendStr appends S to Dest   }

procedure AppendStr(var Dest: String; const S: string);
begin
Dest := Dest + S;
end ;

{   UpperCase returns a copy of S where all lowercase characters ( from a to z )
    have been converted to uppercase   }

function UpperCase(const S: string): string;
var i: integer;
begin
result := S;
i := Length(S);
while i <> 0 do begin
   if (result[i] in ['a'..'z']) then result[i] := char(byte(result[i]) - 32);
   Dec(i);
   end;
end;

{   LowerCase returns a copy of S where all uppercase characters ( from A to Z )
    have been converted to lowercase  }

function LowerCase(const S: string): string;
var i: integer;
begin
result := S;
i := Length(result);
while i <> 0 do begin
   if (result[i] in ['A'..'Z']) then result[i] := char(byte(result[i]) + 32);
   dec(i);
   end;
end;

{   CompareStr compares S1 and S2, the result is the based on
    substraction of the ascii values of the characters in S1 and S2
    case     result
    S1 < S2  < 0
    S1 > S2  > 0
    S1 = S2  = 0     }

function CompareStr(const S1, S2: string): Integer;
var count, count1, count2: integer;
begin
result := 0;
Count1 := Length(S1);
Count2 := Length(S2);
if Count1 > Count2 then Count := Count2
else Count := Count1;
result := CompareMemRange(Pointer(S1),Pointer(S2), Count);
if (result = 0) and (Count1 <> Count2) then begin
   if Count1 > Count2 then result := ord(s1[Count1 + 1])
   else result := -ord(s2[Count2 + 1]);
   end ;
end ;

{   CompareMemRange returns the result of comparison of Length bytes at P1 and P2
    case       result
    P1 < P2    < 0
    P1 > P2    > 0
    P1 = P2    = 0    }

function CompareMemRange(P1, P2: Pointer; Length: cardinal): integer;
var i: integer;
begin
i := 0;
result := 0;
while (result = 0) and (i < length) do begin
   result := byte(P1^) - byte(P2^);
   P1 := P1 + 1;
   P2 := P2 + 1;
   i := i + 1;
   end ;
end ;

function CompareMem(P1, P2: Pointer; Length: cardinal): Boolean;
var
  i: Integer;
begin
  for i := 0 to Length - 1 do
  begin
    if Byte(P1^) <> Byte(P2^) then
    begin
      Result := False;
      exit;
    end;
    Inc(P1);
    Inc(P2);
  end;
  Result := True;
end;


{   CompareText compares S1 and S2, the result is the based on
    substraction of the ascii values of characters in S1 and S2
    comparison is case-insensitive
    case     result
    S1 < S2  < 0
    S1 > S2  > 0
    S1 = S2  = 0     }

function CompareText(const S1, S2: string): integer;
var i, count, count1, count2: integer; Chr1, Chr2: byte;
begin
result := 0;
Count1 := Length(S1);
Count2 := Length(S2);
if Count1 > Count2 then Count := Count2
else Count := Count1;
i := 0;
while (result = 0) and (i < count) do begin
   inc (i);
   Chr1 := byte(s1[i]);
   Chr2 := byte(s2[i]);
   if Chr1 in [97..122] then dec(Chr1,32);
   if Chr2 in [97..122] then dec(Chr2,32);
   result := Chr1 - Chr2;
   end ;
if (result = 0) then
  result:=(count1-count2);
end ;

{==============================================================================}
{   Ansi string functions                                                      }
{   these functions rely on the character set loaded by the OS                 }
{==============================================================================}


function AnsiUpperCase(const s: string): string;
var len, i: integer;
begin
len := length(s);
SetLength(result, len);
for i := 1 to len do
   result[i] := UpperCaseTable[ord(s[i])];
end ;

function AnsiLowerCase(const s: string): string;
var len, i: integer;
begin
len := length(s);
SetLength(result, len);
for i := 1 to len do
   result[i] := LowerCaseTable[ord(s[i])];
end ;

function AnsiCompareStr(const S1, S2: string): integer;

Var I,L1,L2 : Longint;

begin
  Result:=0;
  L1:=Length(S1);
  L2:=Length(S2);
  I:=1;
  While (Result=0) and ((I<=L1) and (I<=L2)) do
    begin
    Result:=Ord(S1[I])-Ord(S2[I]); //!! Must be replaced by ansi characters !!
    Inc(I);
    end;
  If Result=0 Then
    Result:=L1-L2;
end;

function AnsiCompareText(const S1, S2: string): integer;
Var I,L1,L2 : Longint;

begin
  Result:=0;
  L1:=Length(S1);
  L2:=Length(S2);
  I:=1;
  While (Result=0) and ((I<=L1) and (I<=L2)) do
    begin
    Result:=Ord(LowerCaseTable[Ord(S1[I])])-Ord(LowerCaseTable[Ord(S2[I])]); //!! Must be replaced by ansi characters !!
    Inc(I);
    end;
  If Result=0 Then
    Result:=L1-L2;
end;

function AnsiStrComp(S1, S2: PChar): integer;

begin
  Result:=0;
  If S1=Nil then
    begin
    If S2=Nil Then Exit;
    result:=-1;
    end;
  If S2=Nil then
    begin
    Result:=1;
    exit;
    end;
  Repeat
    Result:=Ord(S1[0])-Ord(S2[0]); //!! Must be replaced by ansi characters !!
    Inc(S1);
    Inc(S2);
  Until (Result<>0) or ((S1[0]=#0) or (S2[0]=#0))
end;

function AnsiStrIComp(S1, S2: PChar): integer;

begin
  Result:=0;
  If S1=Nil then
    begin
    If S2=Nil Then Exit;
    result:=-1;
    end;
  If S2=Nil then
    begin
    Result:=1;
    exit;
    end;
  Repeat
    Result:=Ord(LowerCaseTable[Ord(S1[0])])-Ord(LowerCaseTable[Ord(S2[0])]); //!! Must be replaced by ansi characters !!
    Inc(S1);
    Inc(S2);
  Until (Result<>0) or ((S1[0]=#0) or (S2[0]=#0))
end;

function AnsiStrLComp(S1, S2: PChar; MaxLen: cardinal): integer;

Var I : longint;

begin
  Result:=0;
  If MaxLen=0 then exit;
  If S1=Nil then
    begin
    If S2=Nil Then Exit;
    result:=-1;
    end;
  If S2=Nil then
    begin
    Result:=1;
    exit;
    end;
  I:=0;
  Repeat
    Result:=Ord(S1[0])-Ord(S2[0]); //!! Must be replaced by ansi characters !!
    Inc(S1);
    Inc(S2);
    Inc(I);
  Until (Result<>0) or ((S1[0]=#0) or (S2[0]=#0)) or (I=MaxLen)
end ;

function AnsiStrLIComp(S1, S2: PChar; MaxLen: cardinal): integer;

Var I : longint;

begin
  Result:=0;
  If MaxLen=0 then exit;
  If S1=Nil then
    begin
    If S2=Nil Then Exit;
    result:=-1;
    end;
  If S2=Nil then
    begin
    Result:=1;
    exit;
    end;
  I:=0;
  Repeat
    Result:=Ord(LowerCaseTable[Ord(S1[0])])-Ord(LowerCaseTable[Ord(S2[0])]); //!! Must be replaced by ansi characters !!
    Inc(S1);
    Inc(S2);
    Inc(I);
  Until (Result<>0) or ((S1[0]=#0) or (S2[0]=#0)) or (I=MaxLen)
end ;

function AnsiStrLower(Str: PChar): PChar;
begin
result := Str;
if Str <> Nil then begin
   while Str^ <> #0 do begin
      Str^ := LowerCaseTable[byte(Str^)];
      Str := Str + 1;
      end ;
   end ;
end ;

function AnsiStrUpper(Str: PChar): PChar;
begin
result := Str;
if Str <> Nil then begin
   while Str^ <> #0 do begin
      Str^ := UpperCaseTable[byte(Str^)];
      Str := Str + 1;
      end ;
   end ;
end ;

function AnsiLastChar(const S: string): PChar;

begin
  //!! No multibyte yet, so we return the last one.
  result:=StrEnd(Pchar(S));
  Dec(Result);
end ;

function AnsiStrLastChar(Str: PChar): PChar;
begin
  //!! No multibyte yet, so we return the last one.
  result:=StrEnd(Str);
  Dec(Result);
end ;

{==============================================================================}
{  End of Ansi functions                                                       }
{==============================================================================}

{   Trim returns a copy of S with blanks characters on the left and right stripped off   }

Const WhiteSpace = [' ',#10,#13,#9];

function Trim(const S: string): string;
var Ofs, Len: integer;
begin
  len := Length(S);
  while (Len>0) and (S[Len] in WhiteSpace) do
   dec(Len);
  Ofs := 1;
  while (Ofs<=Len) and (S[Ofs] in WhiteSpace) do
   Inc(Ofs);
  result := Copy(S, Ofs, 1 + Len - Ofs);
end ;

{   TrimLeft returns a copy of S with all blank characters on the left stripped off  }

function TrimLeft(const S: string): string;
var i,l:integer;
begin
  l := length(s);
  i := 1;
  while (i<=l) and (s[i] in whitespace) do
   inc(i);
  Result := copy(s, i, l);
end ;

{   TrimRight returns a copy of S with all blank characters on the right stripped off  }

function TrimRight(const S: string): string;
var l:integer;
begin
  l := length(s);
  while (l>0) and (s[l] in whitespace) do
   dec(l);
  result := copy(s,1,l);
end ;

{   QuotedStr returns S quoted left and right and every single quote in S
    replaced by two quotes   }

function QuotedStr(const S: string): string;
begin
result := AnsiQuotedStr(s, '''');
end ;

{   AnsiQuotedStr returns S quoted left and right by Quote,
    and every single occurance of Quote replaced by two   }

function AnsiQuotedStr(const S: string; Quote: char): string;
var i, j, count: integer;
begin
result := '' + Quote;
count := length(s);
i := 0;
j := 0;
while i < count do begin
   i := i + 1;
   if S[i] = Quote then begin
      result := result + copy(S, 1 + j, i - j) + Quote;
      j := i;
      end ;
   end ;
if i <> j then
   result := result + copy(S, 1 + j, i - j);
result := result + Quote;
end ;

{   AnsiExtractQuotedStr returns a copy of Src with quote characters
    deleted to the left and right and double occurances
    of Quote replaced by a single Quote   }

function AnsiExtractQuotedStr(Const Src: PChar; Quote: Char): string;
var i: integer; P, Q: PChar;
begin
P := Src;
if Src^ = Quote then P := P + 1;
Q := StrEnd(P);
if PChar(Q - 1)^ = Quote then Q := Q - 1;
SetLength(result, Q - P);
i := 0;
while P <> Q do begin
   i := i + 1;
   result[i] := P^;
   if (P^ = Quote) and (PChar(P + 1)^ = Quote) then
      P := P + 1;
   P := P + 1;
   end ;
SetLength(result, i);
end ;

{   AdjustLineBreaks returns S with all CR characters not followed by LF
    replaced with CR/LF  }
//  under Linux all CR characters or CR/LF combinations should be replaced with LF

function AdjustLineBreaks(const S: string): string;
var i, j, count: integer;
begin
result := '';
i := 0;
j := 0;
count := Length(S);
while i < count do begin
   i := i + 1;
{$ifndef linux}
   if (S[i] = #13) and ((i = count) or (S[i + 1] <> #10)) then
     begin
     result := result + Copy(S, 1 + j, i - j) + #10;
     j := i;
     end;
{$else}
   If S[i]=#13 then
     begin
     Result:= Result+Copy(S,J+1,i-j-1)+#10;
     If I<>Count Then
       If S[I+1]=#10 then inc(i);
     J :=I;
     end;
{$endif}
   end ;
if j <> i then
   result := result + copy(S, 1 + j, i - j);
end ;

{   IsValidIdent returns true if the first character of Ident is in:
    'A' to 'Z', 'a' to 'z' or '_' and the following characters are
    on of: 'A' to 'Z', 'a' to 'z', '0'..'9' or '_'    }

function IsValidIdent(const Ident: string): boolean;
var i, len: integer;
begin
result := false;
len := length(Ident);
if len <> 0 then begin
   result := Ident[1] in ['A'..'Z', 'a'..'z', '_'];
   i := 1;
   while (result) and (i < len) do begin
      i := i + 1;
      result := result and (Ident[i] in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
      end ;
   end ;
end ;

{   IntToStr returns a string representing the value of Value    }

function IntToStr(Value: integer): string;
begin
System.Str(Value, result);
end ;

{   IntToHex returns a string representing the hexadecimal value of Value   }

const
   HexDigits: array[0..15] of char = '0123456789ABCDEF';

function IntToHex(Value: integer; Digits: integer): string;
var i: integer;
begin
SetLength(result, digits);
for i := 0 to digits - 1 do begin
   result[digits - i] := HexDigits[value and 15];
   value := value shr 4;
   end ;
end ;

{   StrToInt converts the string S to an integer value,
    if S does not represent a valid integer value EConvertError is raised  }

function StrToInt(const S: string): integer;

var Error: word;

begin
  Val(S, result, Error);
  if Error <> 0 then raise EConvertError.createfmt(SInValidInteger,[S]);
end ;

{   StrToIntDef converts the string S to an integer value,
    Default is returned in case S does not represent a valid integer value  }

function StrToIntDef(const S: string; Default: integer): integer;
var Error: word;
begin
Val(S, result, Error);
if Error <> 0 then result := Default;
end ;

{   LoadStr returns the string resource Ident.   }

function LoadStr(Ident: integer): string;
begin
  result:='';
end ;

{   FmtLoadStr returns the string resource Ident and formats it accordingly   }


function FmtLoadStr(Ident: integer; const Args: array of const): string;
begin
  result:='';
end;

Const
  feInvalidFormat   = 1;
  feMissingArgument = 2;
  feInvalidArgIndex = 3;

{$ifdef fmtdebug}
Procedure Log (Const S: String);
begin
 Writeln (S);
end;
{$endif}


Procedure DoFormatError (ErrCode : Longint);
Var
  S : String;
begin
  //!! must be changed to contain format string...
  S:='';
  Case ErrCode of
   feInvalidFormat : raise EConvertError.Createfmt(SInvalidFormat,[s]);
   feMissingArgument : raise EConvertError.Createfmt(SArgumentMissing,[s]);
   feInvalidArgIndex : raise EConvertError.Createfmt(SInvalidArgIndex,[s]);
 end;
end;


Function Format (Const Fmt : String; const Args : Array of const) : String;

Var ChPos,OldPos,ArgPos,DoArg,Len : Longint;
    Hs,ToAdd : String;
    Index,Width,Prec : Longint;
    Left : Boolean;
    Fchar : char;

  {
    ReadFormat reads the format string. It returns the type character in
    uppercase, and sets index, Width, Prec to their correct values,
    or -1 if not set. It sets Left to true if left alignment was requested.
    In case of an error, DoFormatError is called.
  }

  Function ReadFormat : Char;

  Var Value : longint;

    Procedure ReadInteger;

    Var Code : Word;

    begin
      If Value<>-1 then exit; // Was already read.
      OldPos:=chPos;
      While (Chpos<=Len) and
            (Pos(Fmt[chpos],'1234567890')<>0) do inc(chpos);
      If Chpos>len then
        DoFormatError(feInvalidFormat);
      If Fmt[Chpos]='*' then
        begin
        If (Chpos>OldPos) or (ArgPos>High(Args))
           or (Args[ArgPos].Vtype<>vtInteger) then
          DoFormatError(feInvalidFormat);
        Value:=Args[ArgPos].VInteger;
        Inc(ArgPos);
        Inc(chPos);
        end
      else
        begin
        If (OldPos<chPos) Then
          begin
          Val (Copy(Fmt,OldPos,ChPos-OldPos),value,code);
          // This should never happen !!
          If Code>0 then DoFormatError (feInvalidFormat);
          end
        else
          Value:=-1;
        end;
    end;

    Procedure ReadIndex;

    begin
      ReadInteger;
      If Fmt[ChPos]=':' then
        begin
        If Value=-1 then DoFormatError(feMissingArgument);
        Index:=Value;
        Value:=-1;
        Inc(Chpos);
        end;
{$ifdef fmtdebug}
      Log ('Read index');
{$endif}
    end;

    Procedure ReadLeft;

    begin
      If Fmt[chpos]='-' then
        begin
        left:=True;
        Inc(chpos);
        end
      else
        Left:=False;
{$ifdef fmtdebug}
      Log ('Read Left');
{$endif}
    end;

    Procedure ReadWidth;

    begin
      ReadInteger;
      If Value<>-1 then
        begin
        Width:=Value;
        Value:=-1;
        end;
{$ifdef fmtdebug}
      Log ('Read width');
{$endif}
    end;

    Procedure ReadPrec;

    begin
      If Fmt[chpos]='.' then
        begin
        inc(chpos);
        ReadInteger;
        If Value=-1 then DoFormaterror(feMissingArgument);
        prec:=Value;
        end;
{$ifdef fmtdebug}
      Log ('Read precision');
{$endif}
    end;

  begin
{$ifdef fmtdebug}
    Log ('Start format');
{$endif}
    Index:=-1;
    Width:=-1;
    Prec:=-1;
    Value:=-1;
    inc(chpos);
    If Fmt[Chpos]='%' then exit('%');
    ReadIndex;
    ReadLeft;
    ReadWidth;
    ReadPrec;
    ReadFormat:=Upcase(Fmt[ChPos]);
{$ifdef fmtdebug}
    Log ('End format');
{$endif}
end;


{$ifdef fmtdebug}
Procedure DumpFormat (C : char);
begin
  Write ('Fmt : ',fmt:10);
  Write (' Index : ',Index:3);
  Write (' Left  : ',left:5);
  Write (' Width : ',Width:3);
  Write (' Prec  : ',prec:3);
  Writeln (' Type  : ',C);
end;
{$endif}


function Checkarg (AT : Longint;err:boolean):boolean;
{
  Check if argument INDEX is of correct type (AT)
  If Index=-1, ArgPos is used, and argpos is augmented with 1
  DoArg is set to the argument that must be used.
}
begin
  result:=false;
  if Index=-1 then
    begin
    DoArg:=Argpos;
    inc(ArgPos);
    end
  else
    DoArg:=Index;
  If (Doarg>High(Args)) or (Args[Doarg].Vtype<>AT) then
   begin
     if err then
      DoFormatError(feInvalidArgindex);
     dec(ArgPos);
     exit;
   end;
  result:=true;
end;

Const Zero = '000000000000000000000000000000000000000000000000000000000000000';

begin
  Result:='';
  Len:=Length(Fmt);
  Chpos:=1;
  OldPos:=1;
  ArgPos:=0;
  While chpos<=len do
    begin
    While (ChPos<=Len) and (Fmt[chpos]<>'%') do
      inc(chpos);
    If ChPos>OldPos Then
      Result:=Result+Copy(Fmt,OldPos,Chpos-Oldpos);
    If ChPos<Len then
      begin
      FChar:=ReadFormat;
{$ifdef fmtdebug}
      DumpFormat(FCHar);
{$endif}
      Case FChar of
        'D' : begin
              Checkarg(vtinteger,true);
              Width:=Abs(width);
              Str(Args[Doarg].VInteger,ToAdd);
              While Length(ToAdd)<Prec do
                begin
                Index:=Prec-Length(ToAdd);
                If Index>64 then Index:=64;
                ToAdd:=Copy(Zero,1,Index)+ToAdd;
                end;
              end;
        'E' : begin
              CheckArg(vtExtended,true);
              ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffexponent,Prec,3);
              end;
        'F' : begin
              CheckArg(vtExtended,true);
              ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffFixed,9999,Prec);
              end;
        'G' : begin
              CheckArg(vtExtended,true);
              ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffGeneral,Prec,3);
              end;
        'N' : begin
              CheckArg(vtExtended,true);
              ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffNumber,9999,Prec);
              end;
        'M' : begin
              CheckArg(vtExtended,true);
              ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffCurrency,9999,Prec);
              end;
        'S' : begin
                if CheckArg(vtString,false) then
                  hs:=Args[doarg].VString^
                else
                  if CheckArg(vtChar,false) then
                    hs:=Args[doarg].VChar
                else
                  if CheckArg(vtPChar,false) then
                    hs:=Args[doarg].VPChar
                else
                  if CheckArg(vtAnsiString,true) then
                    hs:=ansistring(Args[doarg].VAnsiString);
                Index:=Length(hs);
                If (Prec<>-1) and (Index>Prec) then
                  Index:=Prec;
                ToAdd:=Copy(hs,1,Index);
              end;
        'P' : Begin
              CheckArg(vtpointer,true);
              ToAdd:=HexStr(Longint(Args[DoArg].VPointer),8);
              // Insert ':'. Is this needed in 32 bit ? No it isn't.
              // Insert(':',ToAdd,5);
              end;
        'X' : begin
              Checkarg(vtinteger,true);
              If Prec>15 then
                ToAdd:=HexStr(Args[Doarg].VInteger,15)
              else
                begin
                // determine minimum needed number of hex digits.
                Index:=1;
                While (DWord(1 shl (Index*4))<=DWord(Args[DoArg].VInteger)) and (index<8) do
                 inc(Index);
                If Index>Prec then
                  Prec:=Index;
                ToAdd:=HexStr(Args[DoArg].VInteger,Prec);
                end;
              end;
        '%': ToAdd:='%';
      end;
      If Width<>-1 then
        If Length(ToAdd)<Width then
          If not Left then
            ToAdd:=Space(Width-Length(ToAdd))+ToAdd
          else
            ToAdd:=ToAdd+space(Width-Length(ToAdd));
      Result:=Result+ToAdd;
      end;
    inc(chpos);
    Oldpos:=chpos;
    end;
end;

Function FormatBuf (Var Buffer; BufLen : Cardinal;
                     Const Fmt; fmtLen : Cardinal;
                     Const Args : Array of const) : Cardinal;

Var S,F : String;

begin
  Setlength(F,fmtlen);
  Move(fmt,F[1],fmtlen);
  S:=Format (F,Args);
  If Length(S)>Buflen then
    Result:=Length(S)
  else
    Result:=Buflen;
  Move(S[1],Buffer,Result);
end;

Procedure FmtStr(Var Res: String; Const Fmt : String; Const args: Array of const);

begin
  Res:=Format(fmt,Args);
end;

Function StrFmt(Buffer,Fmt : PChar; Const args: Array of const) : Pchar;

begin
  Buffer[FormatBuf(Buffer^,Maxint,Fmt^,strlen(fmt),args)]:=#0;
  Result:=Buffer;
end;

Function StrLFmt(Buffer : PCHar; Maxlen : Cardinal;Fmt : PChar; Const args: Array of const) : Pchar;

begin
  Buffer[FormatBuf(Buffer^,MaxLen,Fmt^,strlen(fmt),args)]:=#0;
  Result:=Buffer;
end;


function StrToFloat(Value: string): Extended;

var Error: word;

begin
  Val(Value, result, Error);
  if Error <> 0 then raise
     EConvertError.createfmt(SInValidFLoat,[Value]);
end ;

Function FloatToStr(Value: Extended): String;
Begin
  Result := FloatToStrF(Value, ffGeneral, 15, 0);
End;

Function FloatToText(Buffer: PChar; Value: Extended; format: TFloatFormat; Precision, Digits: Integer): Longint;
Var
  Tmp: String[40];
Begin
  Tmp := FloatToStrF(Value, format, Precision, Digits);
  Result := Length(Tmp);
  Move(Tmp[1], Buffer[0], Result);
End;


Function FloatToStrF(Value: Extended; format: TFloatFormat; Precision, Digits: Integer): String;
Var
  P: Integer;
  Negative, TooSmall, TooLarge: Boolean;


Begin
  Case format Of

    ffGeneral:

      Begin
        If (Precision = -1) Or (Precision > 15) Then Precision := 15;
        TooSmall := (Abs(Value) < 0.00001) and (Value>0.0);
        If Not TooSmall Then
        Begin
          Str(Value:0:999, Result);
          P := Pos('.', Result);
          Result[P] := DecimalSeparator;
          TooLarge := P > Precision + 1;
        End;

        If TooSmall Or TooLarge Then
          begin
          Result := FloatToStrF(Value, ffExponent, Precision, Digits);
          // Strip unneeded zeroes.
          P:=Pos('E',result)-1;
          If P<>-1 then
             While (P>1) and (Result[P]='0') do
               begin
               system.Delete(Result,P,1);
               Dec(P);
               end;
          end
        else
          begin
          P := Length(Result);
          While Result[P] = '0' Do Dec(P);
          If Result[P] = DecimalSeparator Then Dec(P);
          SetLength(Result, P);
          end;
      End;

    ffExponent:

      Begin
        If (Precision = -1) Or (Precision > 15) Then Precision := 15;
        Str(Value:Precision + 8, Result);
        Result[3] := DecimalSeparator;
        P:=4;
        While (P>0) and (Digits < P) And (Result[Precision + 5] = '0') do
          Begin
          If P<>1 then
            system.Delete(Result, Precision + 5, 1)
          else
            system.Delete(Result, Precision + 3, 3);
          Dec(P);
          end;
        If Result[1] = ' ' Then
          System.Delete(Result, 1, 1);
      End;

    ffFixed:

      Begin
        If Digits = -1 Then Digits := 2
        Else If Digits > 15 Then Digits := 15;
        Str(Value:0:Digits, Result);
        If Result[1] = ' ' Then
          System.Delete(Result, 1, 1);
        P := Pos('.', Result);
        If P <> 0 Then Result[P] := DecimalSeparator;
      End;

    ffNumber:

      Begin
        If Digits = -1 Then Digits := 2
        Else If Digits > 15 Then Digits := 15;
        Str(Value:0:Digits, Result);
        If Result[1] = ' ' Then System.Delete(Result, 1, 1);
        P := Pos('.', Result);
        If P <> 0 Then Result[P] := DecimalSeparator;
        Dec(P, 3);
        While (P > 1) Do
        Begin
          If Result[P - 1] <> '-' Then Insert(ThousandSeparator, Result, P);
          Dec(P, 3);
        End;
      End;

    ffCurrency:

      Begin
        If Value < 0 Then
        Begin
          Negative := True;
          Value := -Value;
        End
        Else Negative := False;

        If Digits = -1 Then Digits := CurrencyDecimals
        Else If Digits > 18 Then Digits := 18;
        Str(Value:0:Digits, Result);
        If Result[1] = ' ' Then System.Delete(Result, 1, 1);
        P := Pos('.', Result);
        If P <> 0 Then Result[P] := DecimalSeparator;
        Dec(P, 3);
        While (P > 1) Do
        Begin
          Insert(ThousandSeparator, Result, P);
          Dec(P, 3);
        End;

        If Not Negative Then
        Begin
          Case CurrencyFormat Of
            0: Result := CurrencyString + Result;
            1: Result := Result + CurrencyString;
            2: Result := CurrencyString + ' ' + Result;
            3: Result := Result + ' ' + CurrencyString;
          End
        End
        Else
        Begin
          Case NegCurrFormat Of
            0: Result := '(' + CurrencyString + Result + ')';
            1: Result := '-' + CurrencyString + Result;
            2: Result := CurrencyString + '-' + Result;
            3: Result := CurrencyString + Result + '-';
            4: Result := '(' + Result + CurrencyString + ')';
            5: Result := '-' + Result + CurrencyString;
            6: Result := Result + '-' + CurrencyString;
            7: Result := Result + CurrencyString + '-';
            8: Result := '-' + Result + ' ' + CurrencyString;
            9: Result := '-' + CurrencyString + ' ' + Result;
            10: Result := CurrencyString + ' ' + Result + '-';
          End;
        End;
      End;
  End;
End;

{==============================================================================}
{   extra functions                                                            }
{==============================================================================}

{   LeftStr returns Count left-most characters from S }

function LeftStr(const S: string; Count: integer): string;
begin
  result := Copy(S, 1, Count);
end ;

{ RightStr returns Count right-most characters from S }

function RightStr(const S: string; Count: integer): string;
begin
   If Count>Length(S) then
     Count:=Length(S);
   result := Copy(S, 1 + Length(S) - Count, Count);
end;

{    BCDToInt converts the BCD value Value to an integer   }

function BCDToInt(Value: integer): integer;
var i, j: integer;
begin
result := 0;
j := 1;
for i := 0 to SizeOf(Value) shr 1 - 1 do begin
   result := result + j * (Value and 15);
   j := j * 10;
   Value := Value shr 4;
   end ;
end ;

{
   Case Translation Tables
   Can be used in internationalization support.

   Although these tables can be obtained through system calls
   it is better to not use those, since most implementation are not 100%
   WARNING:
   before modifying a translation table make sure that the current codepage
   of the OS corresponds to the one you make changes to
}

const
   { upper case translation table for character set 850 }
   CP850UCT: array[128..255] of char =
   ('�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', 'Y', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�');

   { lower case translation table for character set 850 }
   CP850LCT: array[128..255] of char =
   ('�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�');

   { upper case translation table for character set ISO 8859/1  Latin 1  }
   CPISO88591UCT: array[192..255] of char =
   ( #192, #193, #194, #195, #196, #197, #198, #199,
     #200, #201, #202, #203, #204, #205, #206, #207,
     #208, #209, #210, #211, #212, #213, #214, #215,
     #216, #217, #218, #219, #220, #221, #222, #223,
     #192, #193, #194, #195, #196, #197, #198, #199,
     #200, #201, #202, #203, #204, #205, #206, #207,
     #208, #209, #210, #211, #212, #213, #214, #247,
     #216, #217, #218, #219, #220, #221, #222, #89 );

   { lower case translation table for character set ISO 8859/1  Latin 1  }
   CPISO88591LCT: array[192..255] of char =
   ( #224, #225, #226, #227, #228, #229, #230, #231,
     #232, #233, #234, #235, #236, #237, #238, #239,
     #240, #241, #242, #243, #244, #245, #246, #215,
     #248, #249, #250, #251, #252, #253, #254, #223,
     #224, #225, #226, #227, #228, #229, #230, #231,
     #232, #233, #234, #235, #236, #237, #238, #239,
     #240, #241, #242, #243, #244, #245, #246, #247,
     #248, #249, #250, #251, #252, #253, #254, #255 );

{
  $Log: not supported by cvs2svn $
  Revision 1.35  2000/07/04 17:12:46  peter
    * fixed hex printing for $10 with %x

  Revision 1.34  2000/05/08 17:03:02  sg
  * Changed CompareMem to CompareMemRange and added new (Delphi compatible)
    CompareMem. (CompareMem needs a Boolean as result type, not Integer)

  Revision 1.33  2000/05/08 13:26:42  peter
    * vtchar support for %s
    * define debug -> define fmtdebug

  Revision 1.32  2000/04/03 06:40:37  michael
  * TRim(right|Left) more Delphi compatible

  Revision 1.31  2000/02/09 16:59:33  peter
    * truncated log

  Revision 1.30  2000/02/01 12:53:23  peter
    * fixed rangecheck error in format()

  Revision 1.29  1999/11/06 14:41:31  peter
    * truncated log

  Revision 1.28  1999/10/12 19:16:27  florian
    * bug 645 fixed: format('%x',...) should writes unsigned hexadecimals, also
      prec fixed: max. value in delphi is 15 (and not 32)

  Revision 1.27  1999/10/03 19:42:40  peter
    * fixed comparetext

  Revision 1.26  1999/09/04 20:48:34  florian
    * format('%g',[0.0]) returned long format string, fixed

  Revision 1.25  1999/08/25 13:13:58  michael
  fixed Formaterror, added missing raise

  Revision 1.24  1999/08/16 22:38:53  peter
    * fixed newstr/disposestr

}

