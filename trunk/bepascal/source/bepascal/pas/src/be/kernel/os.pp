{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Olivier Coursiere

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

unit os;

interface

uses
  SupportDefs;

const
  B_LOW_LATENCY = 5;
  B_LOW_PRIORITY = 5;
  B_NORMAL_PRIORITY = 10;
  B_DISPLAY_PRIORITY = 15;
  B_URGENT_DISPLAY_PRIORITY = 20;
  B_REAL_TIME_DISPLAY_PRIORITY = 100;
  B_URGENT_PRIORITY = 110;
  B_REAL_TIME_PRIORITY = 120;

const
  B_OS_NAME_LENGTH = 32;
  B_PAGE_SIZE = 4096;
//  B_INFINITE_TIMEOUT = 9223372036854775807; // $7FFFFFFFFFFFFFFF

// workaround because fpc 1.0.* don't support int64 const -> will
// be changed in fpc 1.1.
// see initialization section
var
  B_INFINITE_TIMEOUT : int64;
  
type
  Area_id = Longint;
  Port_id = Longint;
  Sem_id = Longint;
  Thread_id = Longint;
  Team_id = Longint;

const
  B_NO_LOCK       = 0;
  B_LAZY_LOCK     = 1;
  B_FULL_LOCK     = 2;
  B_CONTIGUOUS    = 3;
  B_LOMEM         = 4;
  
  B_ANY_ADDRESS        = 0;
  B_EXACT_ADDRESS      = 1;
  B_BASE_ADDRESS       = 2;
  B_CLONE_ADDRESS      = 3;
  B_ANY_KERNEL_ADDRESS = 4;
  
  B_READ_AREA  = 1;
  B_WRITE_AREA = 2;

// area  
type
  Area_Info = record
    area : Area_id;
    name : array [0..B_OS_NAME_LENGTH] of char;
    size : Size_t;
    lock : Cardinal;
    protection : Cardinal;
    team : Team_id;
    ram_size : Cardinal;
    copy_count : Cardinal;
    in_count : Cardinal;
    out_count : Cardinal;
    address : Pointer;    
  end;

// Semaphores
type
  Sem_Info = record
    sem : Sem_id;
    team : Team_id;
    name : array [0..B_OS_NAME_LENGTH] of char;
    count : integer;
    latest_holder : Thread_id;
  end;

implementation

uses
  SysUtils;
  
initialization
// workaround because fpc 1.0.* don't support int64 const -> will
// be changed in fpc 1.1.
//  B_INFINITE_TIMEOUT := 9223372036854775807;
  B_INFINITE_TIMEOUT := int64($7FFFFFFF) shl 32 + int64($FFFFFFFF);

end.
