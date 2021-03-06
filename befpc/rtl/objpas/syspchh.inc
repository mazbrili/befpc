{
    *********************************************************************
    $Id: syspchh.inc,v 1.1.1.1 2001-07-23 17:17:42 memson Exp $
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

{ shared with strings unit }
function strlen(p : pchar) : longint;
function strcopy(dest,source : pchar) : pchar;
function strlcopy(dest,source : pchar;maxlen : longint) : pchar;
function strecopy(dest,source : pchar) : pchar;
function strend(p : pchar) : pchar;
function strcat(dest,source : pchar) : pchar;
function strcomp(str1,str2 : pchar) : longint;
function strlcomp(str1,str2 : pchar;l : longint) : longint;
function stricomp(str1,str2 : pchar) : longint;
function strmove(dest,source : pchar;l : longint) : pchar;
function strlcat(dest,source : pchar;l : longint) : pchar;
function strscan(p : pchar;c : char) : pchar;
function strrscan(p : pchar;c : char) : pchar;
function strlower(p : pchar) : pchar;
function strupper(p : pchar) : pchar;
function strlicomp(str1,str2 : pchar;l : longint) : longint;
function strpos(str1,str2 : pchar) : pchar;
function strnew(p : pchar) : pchar;

{ Different from strings unit - ansistrings or different behaviour }
function StrPas(Str: PChar): string;
function StrPCopy(Dest: PChar; Source: string): PChar;
function StrPLCopy(Dest: PChar; Source: string; MaxLen: cardinal): PChar;
function StrAlloc(Size: cardinal): PChar;
function StrBufSize(Str: PChar): cardinal;
procedure StrDispose(Str: PChar);

{
  $Log: not supported by cvs2svn $
  Revision 1.5  2000/02/09 16:59:32  peter
    * truncated log

  Revision 1.4  1999/08/24 13:14:51  peter
    * disposestr allocstr compatible with delphi

}

