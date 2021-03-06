{
    $Id: wstrings.inc,v 1.1.1.1 2001-07-23 17:17:40 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Florian Klaempfl,
    member of the Free Pascal development team.

    This file implements support routines for WideStrings with FPC

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{
Type
  PWideRec = ^TWideRec;
  TWideRec = Packed Record
    Maxlen,
    len,
    ref   : Longint;
    First : WChar;
  end;
}

Procedure UniqueWideString(Var S : WideString); [Public,Alias : 'FPC_WIDESTR_UNIQUE'];
{
  Make sure reference count of S is 1,
  using copy-on-write semantics.
}

begin
end;

{
  $Log: not supported by cvs2svn $
  Revision 1.2  2000/01/07 16:41:37  daniel
    * copyright 2000

  Revision 1.1  1999/12/18 14:55:53  florian
    + initial version

}
