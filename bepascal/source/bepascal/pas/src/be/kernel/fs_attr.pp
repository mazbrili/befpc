unit fs_attr;

// Description: Interface to extended file attributes.

interface

uses
  SupportDefs;

{$I beostypes.inc}

type
  attr_info = record
    at_type : Longint; // uint32 type 
    size    : off_t;   // off_t size
  end;

// Note: in the following methods, I used: integer (32 bits) = int (?? bits)
// Please confirm/fix this.

// I also renamed the 'type' parameter to attype (attribute type)

function fs_read_attr(fd : Integer; const attribute : PChar; attype : Longword;
                      pos : off_t; buf : Pointer; count : size_t)
         : ssize_t; cdecl; external 'root' name 'fs_read_attr';

function fs_write_attr(fd : Integer; const attribute : PChar; attype : Longword;
                       pos : off_t; const buf : Pointer; count : size_t)
         : ssize_t; cdecl; external 'root' name 'fs_write_attr';

function fs_remove_attr(fd : Integer; const attr : PChar) : Integer;
            cdecl; external 'root' name 'fs_remove_attr';

function fs_open_attr_dir(const path : PChar) : DIR;
            cdecl; external 'root' name 'fs_open_attr_dir';

function fs_fopen_attr_dir(fd : Integer) : DIR;
            cdecl; external 'root' name 'fs_fopen_attr_dir';

function fs_close_attr_dir(dirp : DIR) : Integer;
            cdecl; external 'root' name 'fs_close_attr_dir';

function fs_read_attr_dir(dirp : DIR) : dirent;
            cdecl; external 'root' name 'fs_read_attr_dir';

procedure fs_rewind_attr_dir(dirp : DIR);
            cdecl; external 'root' name 'fs_rewind_attr_dir';

function fs_stat_attr(fd : Integer; const name : PChar; ai : attr_info) : Integer;
            cdecl; external 'root' name 'fs_stat_attr';

implementation

end.