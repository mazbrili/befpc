{   BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002-2003 Olivier Coursiere
                            Oscar Lesta

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

unit OS;

interface

uses
  SupportDefs, StorageDefs;

const
  B_OS_NAME_LENGTH = 32;
  B_PAGE_SIZE = 4096;
//  B_INFINITE_TIMEOUT = 9223372036854775807; // $7FFFFFFFFFFFFFFF

// workaround because fpc 1.0.* doesn't support int64 const -> will
// be changed in fpc 2.x
// see initialization section
var
  B_INFINITE_TIMEOUT : int64;

type
  area_id   = Longint;
  port_id   = Longint;
  sem_id    = Longint;
  thread_id = Longint;
  team_id   = Longint;

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
  area_info = record
    area : area_id;
    name : array[0..B_OS_NAME_LENGTH - 1] of Char; // we could do string[B_OS_NAME_LENGTH]
    size : size_t;
    lock : Cardinal;
    protection : Cardinal;
    team : team_id;
    ram_size : Cardinal;
    copy_count : Cardinal;
    in_count : Cardinal;
    out_count : Cardinal;
    address : Pointer;    
  end;

                                         // void **start_addr;
function create_area(const name : PChar; start_addr : Pointer;
                     addr_spec : Longword; size : size_t; lock : Longword;
                     protection : Longword)
         : area_id; cdecl; external 'root' name 'create_area';

                                        // void **dest_addr;
function clone_area(const name : PChar; dest_addr : Pointer;
                    addr_spec : Longword; protection : Longword;
                    source : area_id)
         : area_id; cdecl; external 'root' name 'clone_area';

function find_area(const name : PChar) : area_id;
            cdecl; external 'root' name 'find_area';
function area_for(addr : Pointer) : area_id;
            cdecl; external 'root' name 'area_for';
function delete_area(id : area_id): status_t;
            cdecl; external 'root' name 'delete_area';
function resize_area(id : area_id; new_size : size_t) : status_t;
            cdecl; external 'root' name 'resize_area';

function set_area_protection(id : area_id; new_protection : Longword)
         : status_t; cdecl; external 'root' name 'set_area_protection';

function get_area_info(id : area_id; var ainfo : area_info) : status_t;
function get_next_area_info(team : team_id; cookie : Pointer;
                            var ainfo : area_info) : status_t;

//--------------------------------------------------------------------------

// Ports

type
  port_info =record
    port : port_id;
    team : team_id;
    name : array[0..B_OS_NAME_LENGTH - 1] of Char; // String[B_OS_NAME_LENGTH] ?
    capacity : Longint;    // queue depth
    queue_count : Longint; // # msgs waiting to be read
    total_count : Longint; // total # msgs read so far
  end;

function create_port(capacity : Longint; const name : PChar) : port_id;
            cdecl; external 'root' name 'create_port';
function find_port(const name : PChar) : port_id;
            cdecl; external 'root' name 'find_port';

function write_port(port : port_id; code : Longint; const buf : Pointer;
                    buf_size : size_t)
         : status_t; cdecl; external 'root' name 'write_port';

function read_port(port : port_id; code : Longint; buf : Pointer;
                   buf_size : size_t)
         : status_t; cdecl; external 'root' name 'read_port';

function write_port_etc(port : port_id; code : Longint; const buf : Pointer;
                        buf_size : size_t; flags : Longword;
                        timeout : bigtime_t)
         : status_t; cdecl; external 'root' name 'write_port_etc';

function read_port_etc(port : port_id; var code : Longint; var buf : Pointer;
                       buf_size : size_t; flags : Longword; timeout : bigtime_t)
         : status_t; cdecl; external 'root' name 'read_port_etc';

function port_buffer_size(port : port_id) : ssize_t;
            cdecl; external 'root' name 'port_buffer_size';

function port_buffer_size_etc(port : port_id; flags : Longword;
                              timeout : bigtime_t)
         : ssize_t; cdecl; external 'root' name 'port_buffer_size_etc';

function port_count(port : port_id) : ssize_t;
            cdecl; external 'root' name 'port_count';

function set_port_owner(port : port_id; team : team_id)
         : status_t; cdecl; external 'root' name 'set_port_owner';

function close_port(port : port_id) : status_t;
             cdecl; external 'root' name 'close_port';

function delete_port(port : port_id) : status_t;
             cdecl; external 'root' name 'delete_port';


// These were macros.
function get_port_info(port : port_id; info : port_info) : status_t;
function get_next_port_info(team : team_id; var cookie : Pointer; var info : port_info) : status_t;

//--------------------------------------------------------------------------


const
  B_LOW_LATENCY = 5;
  B_LOW_PRIORITY = 5;
  B_NORMAL_PRIORITY = 10;
  B_DISPLAY_PRIORITY = 15;
  B_URGENT_DISPLAY_PRIORITY = 20;
  B_REAL_TIME_DISPLAY_PRIORITY = 100;
  B_URGENT_PRIORITY = 110;
  B_REAL_TIME_PRIORITY = 120;
  

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


// --- These were macros ---

function _get_area_info(id : area_id; var ainfo : area_info; size : size_t)
         : status_t; cdecl; external 'root' name '_get_area_info';

// int32 * == Pointer ?
function _get_next_area_info(team : team_id; cookie : Pointer;
                             var ainfo : area_info; size : size_t)
         : status_t; cdecl; external 'root' name '_get_next_area_info';

function get_area_info(id : area_id; var ainfo : area_info) : status_t;
begin
  Result := _get_area_info(id, ainfo, SizeOf(ainfo));
end;

function get_next_area_info(team : team_id; cookie : Pointer; var ainfo : area_info) : status_t;
begin
  Result := _get_next_area_info(team, cookie, ainfo, SizeOf(ainfo));
end;

// --- ^^ These were macros ^^ ---

function _get_port_info(port : port_id; var info : port_info; size : size_t)
         : status_t; cdecl; external 'root' name '_get_port_info';
function _get_next_port_info(team : team_id; var cookie : Pointer;
                             var info : port_info; size : size_t)
         : status_t; cdecl; external 'root' name '_get_next_port_info';

function get_port_info(port : port_id; info : port_info) : status_t;
begin
  Result := _get_port_info(port, info, SizeOf(info));
end;

function get_next_port_info(team : team_id; var cookie : Pointer;
                            var info : port_info) : status_t;
begin
  Result := _get_next_port_info(team, cookie, info, SizeOf(info));
end;


initialization
// workaround because fpc 1.0.* don't support int64 const -> will
// be changed in fpc 1.1.
//  B_INFINITE_TIMEOUT := 9223372036854775807;
  B_INFINITE_TIMEOUT := int64($7FFFFFFF) shl 32 + int64($FFFFFFFF);

end.
