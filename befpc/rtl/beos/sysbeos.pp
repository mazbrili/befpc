{
    $Id: sysbeos.pp,v 1.1.1.1 2001-07-23 17:17:26 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team.

    This is a prototype file to show all function that need to be implemented
    for a new operating system (provided the processor specific
    function are already implemented !)

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{ no stack check in system }

{$DEFINE SHORT_LINEBREAK}
{$S-}
unit SysBeos;

interface

{ include system-independent routine headers }

{$I systemh.inc}

{ include heap support headers }

{$I heaph.inc}

var
  argc : longint;
  argv : ppchar;
  envp : ppchar;

var
  UnusedHandle:longint;
  StdInputHandle:longint;
  StdOutputHandle:longint;
  StdErrorHandle:longint;

implementation

{$I sysfiles.inc}

function sys_unlink (a:longint;name:pchar):longint; cdecl; external name 'sys_unlink';
function sys_rename (a:longint;p1:pchar;b:longint;p2:pchar):longint; cdecl; external name 'sys_rename';
function sys_create_area (name:pchar; var start:longint; a,b,c,d:longint):longint; cdecl; external name 'sys_create_area';
function sys_resize_area (handle:longint; size:longint):longint; cdecl; external name 'sys_resize_area';
function sys_mkdir (a:longint; name:pchar; mode:longint):longint; cdecl; external name 'sys_mkdir';
function sys_chdir (a:longint; name:pchar):longint; cdecl; external name 'sys_chdir';
function sys_rmdir (a:longint; name:pchar):longint; cdecl; external name 'sys_rmdir';

{$I system.inc}


{*****************************************************************************
                         System Dependent Exit code
*****************************************************************************}
procedure prthaltproc;external name '_haltproc';

procedure system_exit;
begin
  asm
    jmp prthaltproc
  end;
End;

{*****************************************************************************
                         Stack check code
*****************************************************************************}
procedure int_stackcheck(stack_size:longint);[public,alias:'FPC_STACKCHECK'];
{
  called when trying to get local stack if the compiler directive $S
  is set this function must preserve esi !!!! because esi is set by
  the calling proc for methods it must preserve all registers !!

  With a 2048 byte safe area used to write to StdIo without crossing
  the stack boundary
}
begin
end;

{*****************************************************************************
                              ParamStr/Randomize
*****************************************************************************}

{ number of args }
function paramcount : longint;
begin
  paramcount := argc - 1;
end;

{ argument number l }
function paramstr(l : longint) : string;
begin
  if (l>=0) and (l+1<=argc) then
   paramstr:=strpas(argv[l])
  else
   paramstr:='';
end;

{ set randseed to a new pseudo random value }
procedure randomize;
begin
  {regs.realeax:=$2c00;
  sysrealintr($21,regs);
  hl:=regs.realedx and $ffff;
  randseed:=hl*$10000+ (regs.realecx and $ffff);}
  randseed:=0;
end;

{*****************************************************************************
                              Heap Management
*****************************************************************************}

var myheapstart:longint;
    myheapsize:longint;
    myheaprealsize:longint;
    heap_handle:longint;
    zero:longint;
    
{ first address of heap }
function getheapstart:pointer;
begin
   getheapstart:=pointer(myheapstart);
end;

{ current length of heap }
function getheapsize:longint;
begin
   getheapsize:=myheapsize;
end;

{ function to allocate size bytes more for the program }
{ must return the first address of new data space or -1 if fail }
function Sbrk(size : longint):longint;
var newsize,newrealsize:longint;
begin
  if (myheapsize+size)<=myheaprealsize then begin
    Sbrk:=myheapstart+myheapsize;
    myheapsize:=myheapsize+size;
    exit;
  end;
  newsize:=myheapsize+size;
  newrealsize:=(newsize and $FFFFF000)+$1000;
  if sys_resize_area(heap_handle,newrealsize)=0 then begin
	Sbrk:=myheapstart+myheapsize;
  	myheapsize:=newsize;
	myheaprealsize:=newrealsize;
	exit;
  end;
  Sbrk:=-1;
end;


{ include standard heap management }
{$I heap.inc}


{****************************************************************************
                        Low level File Routines
       All these functions can set InOutRes on errors
 ****************************************************************************}



{ close a file from the handle value }
procedure do_close(handle : longint);
begin
{  writeln ('CLOSE ',handle);}
  if handle<=2 then exit;
  InOutRes:=sys_close(handle);
end;


procedure do_erase(p : pchar);
begin
  if sys_unlink($FF000000,p)<>0 then InOutRes:=1
  else InOutRes:=0;
end;

procedure do_rename(p1,p2 : pchar);
begin
  InOutRes:=sys_rename($FF000000,p1,$FF000000,p2);
end;

function do_write(h,addr,len : longint) : longint;
begin
{  if h>0 then begin
    sys_write ('WRITE handle=%d ',h);
    printf ('addr=%x ',addr);
    printf ('len=%d',len);
    printf ('%c',10);
  end;}
  do_write:=sys_write (h,pointer(addr),len,zero);
  if (do_write<0) then begin
    InOutRes:=do_write;
    do_write:=0;
  end else InOutRes:=0;
end;

function do_read(h,addr,len : longint) : longint;
begin
{  if h>2 then begin
    printf ('READ handle=%d ',h);
    printf ('addr=%x ',addr);
    printf ('len=%d',len);
  end;}
  do_read:=sys_read (h,pointer(addr),len,zero);
  if (do_read<0) then begin
    InOutRes:=do_read;
    do_read:=0;
  end else InOutRes:=0;
end;

function do_filepos(handle : longint) : longint;
begin
  do_filepos:=sys_lseek(handle,0,1); {1=SEEK_CUR}
  if (do_filepos<0) then begin
    InOutRes:=do_filepos;
    do_filepos:=0;
  end else InOutRes:=0;
end;

procedure do_seek(handle,pos : longint);
var s:longint;
begin
  InOutRes:=sys_lseek(handle,pos,0);
  if InOutRes>0 then InOutRes:=0;
end;

function do_seekend(handle:longint):longint;
begin
  do_seekend:=sys_lseek (handle,0,2); {2=SEEK_END}
  if do_seekend<0 then begin
    InOutRes:=do_seekend;
    do_seekend:=0;
  end else InOutRes:=0;
end;

function do_filesize(handle : longint) : longint;
var cur:longint;
begin
  cur:=sys_lseek (handle,0,1); {1=SEEK_CUR}
  if cur<0 then begin
    InOutRes:=cur;
    do_filesize:=0;
    exit;
  end;    
  do_filesize:=sys_lseek (handle,0,2); {2=SEEK_END}
  if do_filesize<0 then begin
    InOutRes:=do_filesize;
    do_filesize:=0;
    exit;
  end;    
  cur:=sys_lseek (handle,cur,0); {0=SEEK_POS}
  if cur<0 then begin
    InOutRes:=cur;
    do_filesize:=0;
    exit;
  end;    
end;

{ truncate at a given position }
procedure do_truncate (handle,pos:longint);
begin
  InOutRes:=1;
end;

procedure do_open(var f;p:pchar;flags:longint);
{
  filerec and textrec have both handle and mode as the first items so
  they could use the same routine for opening/creating.
  when (flags and $100)   the file will be append
  when (flags and $1000)  the file will be truncate/rewritten
  when (flags and $10000) there is no check for close (needed for textfiles)
}
var m:longint;
    mode,h:longint;
begin
{  printf ('OPEN %d ',longint(f));
  printf (' %s',longint(p));
  printf (' %x',flags);}

  m:=0;
  case (flags and $3) of
        $0: begin m:=m or O_RDONLY; mode:=fminput;  end;
        $1: begin m:=m or O_WRONLY; mode:=fmoutput;end;
        $2: begin m:=m or O_RDWR; mode:=fminout; end;
  end;
  
  if (flags and $100)<>0 then m:=m or O_APPEND;
  if (flags and $1000)<>0 then m:=m or O_TRUNC or O_CREAT;
  
{  if (flags and $10000)<>0 then m:=m or O_TEXT else m:=m or O_BINARY;}

  h:=sys_open($FF000000,p,m,0,0);

  if h<0 then InOutRes:=h
  else InOutRes:=0;

  if InOutRes=0 then begin
    FileRec(f).handle:=h;
    FileRec(f).mode:=mode;
  end;
end;

function do_isdevice(handle:longint):boolean;
begin
  do_isdevice:=false;
  InOutRes:=0;
end;


{*****************************************************************************
                           UnTyped File Handling
*****************************************************************************}

{$i file.inc}

{*****************************************************************************
                           Typed File Handling
*****************************************************************************}

{$i typefile.inc}

{*****************************************************************************
                           Text File Handling
*****************************************************************************}

{ should we consider #26 as the  end of a file ? }
{?? $DEFINE EOF_CTRLZ}

{$i text.inc}

{*****************************************************************************
                           Directory Handling
*****************************************************************************}
procedure mkdir(const s : string);[IOCheck];
var t:string;
begin
  t:=s+#0;
  InOutRes:=sys_mkdir ($FF000000,@t[1],493);
end;

procedure rmdir(const s : string);[IOCheck];
var t:string;
begin
  t:=s+#0;
  InOutRes:=sys_rmdir ($FF000000,@t[1]);
end;

procedure chdir(const s : string);[IOCheck];
var t:string;
begin
  t:=s+#0;
  InOutRes:=sys_chdir ($FF000000,@t[1]);
end;

{*****************************************************************************
                             getdir procedure
*****************************************************************************}
type dirent = packed record
	d_dev:longint;
	d_pdev:longint;
	d_ino:int64;
	d_pino:int64;
	d_reclen:word;
	d_name:array[0..255] of char;
  end;

    stat = packed record
      dev:longint;     {"device" that this file resides on}
      ino:int64;       {this file's inode #, unique per device}
      mode:dword;      {mode bits (rwx for user, group, etc)}
      nlink:longint;   {number of hard links to this file}
      uid:dword;       {user id of the owner of this file}
      gid:dword;       {group id of the owner of this file}
      size:int64;      {size of this file (in bytes)}
      rdev:longint;    {device type (not used)}
      blksize:longint; {preferref block size for i/o}
      atime:longint;   {last access time}
      mtime:longint;   {last modification time}
      ctime:longint;   {last change time, not creation time}
      crtime:longint;  {creation time}
    end;
    pstat = ^stat;

function sys_stat (a:longint;path:pchar;info:pstat;n:longint):longint; cdecl; external name 'sys_stat';

function FStat(Path:String;Var Info:stat):Boolean;
{
  Get all information on a file, and return it in Info.
}
var tmp:string;
var p:pchar;
begin
  tmp:=path+#0;
  p:=@tmp[1];
  FStat:=(sys_stat($FF000000,p,@Info,0)=0);
end;


function sys_opendir (a:dword;path:pchar;b:longint):longint; cdecl; external name 'sys_opendir';
function sys_readdir (fd:longint;var de:dirent;a:longint;b:byte):longint; cdecl; external name 'sys_readdir';

function parentdir(fd:longint;dev:longint;ino:int64;var err:longint):string;
var len:longint;
    ent:dirent;
    info:stat;
    name:string;
begin
  err:=0;
  parentdir:='';
  if sys_readdir(fd,ent,$11C,1)=0 then begin
    err:=1;
    exit;
  end;  

  len:=StrLen(@ent.d_name);
  Move(ent.d_name,name[1],len);
  name[0]:=chr(len);
{  writeln ('NAME: "',name,'" = ',ent.d_dev,',',ent.d_ino);}
  if (dev=ent.d_dev) and (ino=ent.d_ino) then begin
    err:=0;
    parentdir:='/'+name;
    exit;
  end;  

  err:=0;
end;


function getdir2:string;
var tmp:string;
    p:pchar;
    info:stat;
    info2:stat;
    ext:string;
    fd:longint;
    name:string;
	cur:string;
	res:string;
	err:longint;
begin
  res:='';
  cur:='';
  
  repeat
  
  FStat(cur+'.',info);
  FStat(cur+'..',info2);
{  writeln ('"." = ',info.dev,',',info.ino);}
  if ((info.dev=info2.dev) and (info.ino=info2.ino)) then begin
    if res='' then getdir2:='/' else getdir2:=res;
    exit;
  end;
  
  tmp:=cur+'..'+#0;
  fd:=sys_opendir ($FF000000,@tmp[1],0);
  repeat
    name:=parentdir(fd,info.dev,info.ino,err);
  until (err<>0) or (name<>'');
  if err<>0 then begin
    getdir2:='';
    exit;
  end;
  res:=name+res;
{  writeln(res);}
  cur:=cur+'../';
  until false;
end;  

procedure getdir(drivenr : byte;var dir : shortstring);
var s:string;
    r:longint;
begin
  drivenr:=0;
  dir:=getdir2;
end;


{*****************************************************************************
                         SystemUnit Initialization
*****************************************************************************}

begin
{ Setup heap }
  zero:=0;
  myheapsize:=$2000;
  myheaprealsize:=$2000;
  myheapstart:=0;
  heap_handle:=sys_create_area('fpcheap',myheapstart,0,myheaprealsize,0,3);
  if heap_handle>0 then begin
    InitHeap;
  end else system_exit;
  
{ Setup IO }
  StdInputHandle:=0;
  StdOutputHandle:=1;
  StdErrorHandle:=2;

  OpenStdIO(Input,fmInput,StdInputHandle);
  OpenStdIO(Output,fmOutput,StdOutputHandle);
  OpenStdIO(StdOut,fmOutput,StdOutputHandle);
  OpenStdIO(StdErr,fmOutput,StdErrorHandle);
  
{ Reset IO Error }
  InOutRes:=0;
end.
