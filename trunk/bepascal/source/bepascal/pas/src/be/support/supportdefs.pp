{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Olivier Coursiere
                       Eric Jourde

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit SupportDefs;

interface

type
    // Descriptive formats
  Status_t = Longint;
  Bigtime_t = int64;
  Type_code = Cardinal;
  Perform_code = Cardinal;
  // For Storage kit
  // TODO : move these declarations in a different unit (but which one ?).
  // C++ declarations are in /boot/develop/headers/posix/sys/types.h,
  // not in SupportDefs.h
  Dev_t = Longint;
  Off_t = int64;

  	// pointer types for FreePascal : to make life easier
  PStatus_t = ^Status_t;
  
  // TODO : import other functions !

    // import from stddef.h
  Size_t = Cardinal;
  SSize_t = Longint;
  
implementation


end.
