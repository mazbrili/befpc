{
    $Id: filerec.inc,v 1.1.1.1 2001-07-23 17:17:30 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    FileRec record definition


    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{
  This file contains the definition of the filerec record.
  It is put separately, so it is available outside the system
  unit without sacrificing TP compatibility.
}

const
  filerecnamelength = 255;
type
  FileRec = Packed Record
    Handle,
    Mode,
    RecSize   : longint;
    _private  : array[1..32] of byte;
    UserData  : array[1..16] of byte;
    name      : array[0..filerecnamelength] of char;
  End;

{
  $Log: not supported by cvs2svn $
  Revision 1.8  2000/02/09 16:59:29  peter
    * truncated log

  Revision 1.7  2000/01/07 16:41:34  daniel
    * copyright 2000

  Revision 1.6  2000/01/07 16:32:24  daniel
    * copyright 2000 added

}
