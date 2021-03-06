{
    $Id: heaph.inc,v 1.1.1.1 2001-07-23 17:17:33 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    Heap manager interface section

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{ Memorymanager }
type
  PMemoryManager = ^TMemoryManager;
  TMemoryManager = record
    Getmem      : Function(Size:Longint):Pointer;
    Freemem     : Function(var p:pointer):Longint;
    FreememSize : Function(var p:pointer;Size:Longint):Longint;
    AllocMem    : Function(Size:longint):Pointer;
    ReAllocMem  : Function(var p:pointer;Size:longint):Pointer;
    MemSize     : function(p:pointer):Longint;
    MemAvail    : Function:Longint;
    MaxAvail    : Function:Longint;
    HeapSize    : Function:Longint;
  end;
procedure GetMemoryManager(var MemMgr: TMemoryManager);
procedure SetMemoryManager(const MemMgr: TMemoryManager);
function  IsMemoryManagerSet: Boolean;

{ Variables }
const
  growheapsize1 : longint=256*1024;  { < 256k will grow with 256k }
  growheapsize2 : longint=1024*1024; { > 256k will grow with 1m }
  ReturnNilIfGrowHeapFails : boolean = false;
var
  heaporg,heapptr,heapend,heaperror,freelist : pointer;

{ Default MemoryManager functions }
Function  SysGetmem(Size:Longint):Pointer;
Function  SysFreemem(var p:pointer):Longint;
Function  SysFreememSize(var p:pointer;Size:Longint):Longint;
Function  SysMemSize(p:pointer):Longint;
Function  SysAllocMem(size:longint):Pointer;
function  SysTryResizeMem(var p:pointer;size : longint):boolean;
Function  SysReAllocMem(var p:pointer;size:longint):Pointer;
Function  Sysmemavail:Longint;
Function  Sysmaxavail:Longint;
Function  Sysheapsize:longint;

{ Tp7 functions }
Procedure Getmem(Var p:pointer;Size:Longint);
Procedure Freemem(Var p:pointer;Size:Longint);
Function  memavail:Longint;
Function  maxavail:Longint;

{ FPC additions }
Function  MemSize(p:pointer):Longint;
Function  heapsize:longint;

{ Delphi functions }
function GetMem(size:longint):pointer;
function Freemem(var p:pointer):longint;
function AllocMem(Size:Longint):pointer;
function ReAllocMem(var p:pointer;Size:Longint):pointer;

{ Needed to solve overloading problem with call from assembler (PFV) }
Procedure AsmGetmem(var p:pointer;size:Longint);
Procedure AsmFreemem(var p:pointer);

{ Do nothing functions, are only here for tp7 compat }
Procedure mark(var p : pointer);
Procedure release(var p : pointer);

{
  $Log: not supported by cvs2svn $
  Revision 1.18  2000/04/07 21:10:35  pierre
    + ReturnNilIfGrowHeapFails used in objects unit
      to handle TMemoryStream out of memory properly
      as MaxAvail is not a good test anymore.

  Revision 1.17  2000/02/09 16:59:30  peter
    * truncated log

  Revision 1.16  2000/01/31 23:41:30  peter
    * reallocmem fixed for freemem() call when size=0

  Revision 1.15  2000/01/20 12:35:35  jonas
    * fixed problem with reallocmem and heaptrc

  Revision 1.14  2000/01/07 16:41:34  daniel
    * copyright 2000

  Revision 1.13  2000/01/07 16:32:24  daniel
    * copyright 2000 added

  Revision 1.12  1999/11/01 13:56:50  peter
    * freemem,reallocmem now get var argument

  Revision 1.11  1999/10/30 17:39:05  peter
    * memorymanager expanded with allocmem/reallocmem

  Revision 1.10  1999/09/17 17:14:12  peter
    + new heap manager supporting delphi freemem(pointer)

}