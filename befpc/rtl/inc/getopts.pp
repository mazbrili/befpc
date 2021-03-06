{
    $Id: getopts.pp,v 1.1.1.1 2001-07-23 17:17:32 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Michael Van Canneyt,
    member of the Free Pascal development team.

    Getopt implementation for Free Pascal, modeled after GNU getopt

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit getopts;
Interface

Const
  No_Argument       = 0;
  Required_Argument = 1;
  Optional_Argument = 2;
  EndOfOptions      = #255;

Type
  POption  = ^TOption;
  TOption = Record
    Name    : String;
    Has_arg : Integer;
    Flag    : PChar;
    Value   : Char;
  end;

  Orderings = (require_order,permute,return_in_order);

Const
  OptSpecifier : set of char=['-'];

Var
  OptArg : String;
  OptInd : Longint;
  OptErr : Boolean;
  OptOpt : Char;

Function GetOpt (ShortOpts : String) : char;
Function GetLongOpts (ShortOpts : String;LongOpts : POption;var Longind : Longint) : char;


Implementation

{$ifdef TP}
uses
  strings;
{$endif}


{***************************************************************************
                               Create an ArgV
***************************************************************************}

{$ifdef TP}

function GetCommandLine:pchar;
begin
  GetCommandLine:=ptr(prefixseg,$81);
end;


function GetCommandFile:pchar;
var
  p : pchar;
begin
  p:=ptr(memw[prefixseg:$2c],0);
  repeat
    while p^<>#0 do
     inc(longint(p));
  { next char also #0 ? }
    inc(longint(p));
    if p^=#0 then
     begin
       inc(longint(p),3);
       GetCommandFile:=p;
       exit;
     end;
  until false;
end;


type
  ppchar = ^pchar;
  apchar = array[0..127] of pchar;
var
  argc  : longint;
  argv  : apchar;

procedure setup_arguments;
var
  arglen,
  count   : longint;
  argstart,
  cmdline : pchar;
  quote   : set of char;
  argsbuf : array[0..127] of pchar;
begin
{ create argv[0] which is the started filename }
  argstart:=GetCommandFile;
  arglen:=strlen(argstart)+1;
  getmem(argsbuf[0],arglen);
  move(argstart^,argsbuf[0]^,arglen);
{ create commandline }
  cmdline:=GetCommandLine;
  count:=1;
  repeat
  { skip leading spaces }
    while cmdline^ in [' ',#9,#13] do
     inc(longint(cmdline));
    case cmdline^ of
      #0 : break;
     '"' : begin
             quote:=['"'];
             inc(longint(cmdline));
           end;
    '''' : begin
             quote:=[''''];
             inc(longint(cmdline));
           end;
    else
     quote:=[' ',#9,#13];
    end;
  { scan until the end of the argument }
    argstart:=cmdline;
    while (cmdline^<>#0) and not(cmdline^ in quote) do
     inc(longint(cmdline));
  { reserve some memory }
    arglen:=cmdline-argstart;
    getmem(argsbuf[count],arglen+1);
    move(argstart^,argsbuf[count]^,arglen);
    argsbuf[count][arglen]:=#0;
  { skip quote }
    if cmdline^ in quote then
     inc(longint(cmdline));
    inc(count);
  until false;
{ create argc }
  argc:=count;
{ create an nil entry }
  argsbuf[count]:=nil;
  inc(count);
{ create the argv }
  move(argsbuf,argv,count shl 2);
end;

{$endif TP}

{***************************************************************************
                               Real Getopts
***************************************************************************}

Var
  NextChar,
  Nrargs,
  first_nonopt,
  last_nonopt   : Longint;
  Ordering      : Orderings;

Procedure Exchange;
var
  bottom,
  middle,
  top,i,len : longint;
  temp      : pchar;
begin
  bottom:=first_nonopt;
  middle:=last_nonopt;
  top:=optind;
  while (top>middle) and (middle>bottom) do
    begin
    if (top-middle>middle-bottom) then
      begin
      len:=middle-bottom;
      for i:=1 to len-1 do
        begin
        temp:=argv[bottom+i];
        argv[bottom+i]:=argv[top-(middle-bottom)+i];
        argv[top-(middle-bottom)+i]:=temp;
        end;
      top:=top-len;
      end
    else
      begin
      len:=top-middle;
      for i:=0 to len-1 do
        begin
        temp:=argv[bottom+i];
        argv[bottom+i]:=argv[middle+i];
        argv[middle+i]:=temp;
        end;
      bottom:=bottom+len;
      end;
    end;
  first_nonopt:=first_nonopt + optind-last_nonopt;
  last_nonopt:=optind;
end; { exchange }


procedure getopt_init (var opts : string);
begin
{ Initialize some defaults. }
  Optarg:='';
  Optind:=1;
  First_nonopt:=1;
  Last_nonopt:=1;
  OptOpt:='?';
  Nextchar:=0;
  case opts[1] of
   '-' : begin
           ordering:=return_in_order;
           delete(opts,1,1);
         end;
   '+' : begin
           ordering:=require_order;
           delete(opts,1,1);
         end;
  else
   ordering:=permute;
  end;
end;



Function Internal_getopt (Var Optstring : string;LongOpts : POption;
                          LongInd : pointer;Long_only : boolean ) : char;
type
  pinteger=^integer;
var
  temp,endopt,
  option_index : byte;
  indfound     : integer;
  currentarg,
  optname      : string;
  p,pfound     : POption;
  exact,ambig  : boolean;
  c            : char;
begin
  optarg:='';
  if optind=0 then
   getopt_init(optstring);
{ Check if We need the next argument. }
  if (optind<nrargs) then
   currentarg:=strpas(argv[optind])
  else
   currentarg:='';
  if (nextchar=0) then
   begin
     if ordering=permute then
      begin
      { If we processed options following non-options : exchange }
        if (first_nonopt<>last_nonopt) and (last_nonopt<>optind) then
         exchange
        else
         if last_nonopt<>optind then
          first_nonopt:=optind;
        while (optind<nrargs) and (not(argv[optind][0] in OptSpecifier) or
              (length(strpas(argv[optind]))=1)) do
         inc(optind);
        last_nonopt:=optind;
      end;
   { Check for '--' argument }
     if optind<nrargs then
      currentarg:=strpas(argv[optind])
     else
      currentarg:='';
     if (optind<>nrargs) and (currentarg='--') then
      begin
        inc(optind);
        if (first_nonopt<>last_nonopt) and (last_nonopt<>optind) then
         exchange
        else
         if first_nonopt=last_nonopt then
          first_nonopt:=optind;
        last_nonopt:=nrargs;
        optind:=nrargs;
      end;
   { Are we at the end of all arguments ? }
     if optind>=nrargs then
      begin
        if first_nonopt<>last_nonopt then
         optind:=first_nonopt;
        Internal_getopt:=EndOfOptions;
        exit;
      end;
     if optind<nrargs then
      currentarg:=strpas(argv[optind])
     else
      currentarg:='';
   { Are we at a non-option ? }
     if not(currentarg[1] in OptSpecifier) or (length(currentarg)=1) then
      begin
        if ordering=require_order then
         begin
           Internal_getopt:=EndOfOptions;
           exit;
         end
        else
         begin
           optarg:=strpas(argv[optind]);
           inc(optind);
           Internal_getopt:=#1;
           exit;
         end;
      end;
   { At this point we're at an option ...}
     nextchar:=2;
     if (longopts<>nil) and ((currentarg[2]='-') and 
                             (currentArg[1]='-')) then
      inc(nextchar);
   { So, now nextchar points at the first character of an option }
   end;
{ Check if we have a long option }
  if longopts<>nil then
   if length(currentarg)>1 then
    if ((currentarg[2]='-') and (currentArg[1]='-'))
       or
       ((not long_only) and (pos(currentarg[2],optstring)<>0)) then
     begin
     { Get option name }
       endopt:=pos('=',currentarg);
       if endopt=0 then
        endopt:=length(currentarg)+1;
       optname:=copy(currentarg,nextchar,endopt-nextchar);
     { Match partial or full }
       p:=longopts;
       pfound:=nil;
       exact:=false;
       ambig:=false;
       option_index:=0;
       indfound:=0;
       while (p^.name<>'') and (not exact) do
        begin
          if pos(optname,p^.name)<>0 then
           begin
             if length(optname)=length(p^.name) then
              begin
                exact:=true;
                pfound:=p;
                indfound:=option_index;
              end
             else
              if pfound=nil then
               begin
                 indfound:=option_index;
                 pfound:=p
               end
              else
               ambig:=true;
           end;
          inc(longint(p),sizeof(toption));
          inc(option_index);
        end;
       if ambig and not exact then
        begin
          if opterr then
           writeln(argv[0],': option "',optname,'" is ambiguous');
          nextchar:=0;
          inc(optind);
          Internal_getopt:='?';
        end;
       if pfound<>nil then
        begin
          inc(optind);
          if endopt<=length(currentarg) then
           begin
             if pfound^.has_arg>0 then
              optarg:=copy(currentarg,endopt+1,length(currentarg)-endopt)
             else
              begin
                if opterr then
                 if currentarg[2]='-' then
                  writeln(argv[0],': option "--',pfound^.name,'" doesn''t allow an argument')
                 else
                  writeln(argv[0],': option "',currentarg[1],pfound^.name,'" doesn''t allow an argument');
                nextchar:=0;
                internal_getopt:='?';
                exit;
              end;
           end
          else { argument in next paramstr...  }
           begin
             if pfound^.has_arg=1 then
              begin
                if optind<nrargs then
                 begin
                   optarg:=strpas(argv[optind]);
                   inc(optind);
                 end { required argument }
                else
                 begin { no req argument}
                   if opterr then
                    writeln(argv[0],': option ',pfound^.name,' requires an argument');
                   nextchar:=0;
                   if optstring[1]=':' then
                    Internal_getopt:=':'
                   else
                    Internal_getopt:='?';
                   exit;
                 end;
              end;
           end; { argument in next parameter end;}
          nextchar:=0;
          if longind<>nil then
           pinteger(longind)^:=indfound+1;
          if pfound^.flag<>nil then
           begin
             pfound^.flag^:=pfound^.value;
             internal_getopt:=#0;
             exit;
           end;
          internal_getopt:=pfound^.value;
          exit;
        end; { pfound<>nil }
      { We didn't find it as an option }
        if (not long_only) or
           ((currentarg[2]='-') or (pos(CurrentArg[nextchar],optstring)=0)) then
         begin
           if opterr then
            if currentarg[2]='-' then
             writeln(argv[0],' unrecognized option "--',optname,'"')
            else
             writeln(argv[0],' unrecognized option "',currentarg[1],optname,'"');
           nextchar:=0;
           inc(optind);
           Internal_getopt:='?';
           exit;
        end;
     end; { Of long options.}
{ We check for a short option. }
  temp:=pos(currentarg[nextchar],optstring);
  c:=currentarg[nextchar];
  inc(nextchar);
  if nextchar>length(currentarg) then
   begin
     inc(optind);
     nextchar:=0;
   end;
  if (temp=0) or (c=':') then
   begin
     if opterr then
      writeln(argv[0],': illegal option -- ',c);
     optopt:=c;
     internal_getopt:='?';
     exit;
   end;
  Internal_getopt:=optstring[temp];
  if optstring[temp+1]=':' then
   if currentarg[temp+2]=':' then
    begin { optional argument }
      optarg:=copy (currentarg,nextchar,length(currentarg)-nextchar+1);
      nextchar:=0;
    end
   else
    begin { required argument }
      if nextchar>0 then
       begin
         optarg:=copy (currentarg,nextchar,length(currentarg)-nextchar+1);
         inc(optind);
       end
      else
       if (optind=nrargs) then
        begin
          if opterr then
           writeln (argv[0],': option requires an argument -- ',optstring[temp]);
          optopt:=optstring[temp];
          if optstring[1]=':' then
           Internal_getopt:=':'
          else
           Internal_Getopt:='?';
        end
       else
        begin
          optarg:=strpas(argv[optind]);
          inc(optind)
        end;
       nextchar:=0;
    end; { End of required argument}
end; { End of internal getopt...}


Function GetOpt(ShortOpts : String) : char;
begin
  getopt:=internal_getopt(shortopts,nil,nil,false);
end;


Function GetLongOpts(ShortOpts : String;LongOpts : POption;var Longind : Longint) : char;
begin
  getlongopts:=internal_getopt(shortopts,longopts,@longind,true);
end;


begin
{ create argv if running under TP }
{$ifdef TP}
  setup_arguments;
{$endif}
{ Needed to detect startup }
  Opterr:=true;
  Optind:=0;
  nrargs:=argc;
end.
{
  $Log: not supported by cvs2svn $
  Revision 1.8  2000/02/09 16:59:29  peter
    * truncated log

  Revision 1.7  2000/01/07 16:41:34  daniel
    * copyright 2000

  Revision 1.6  2000/01/07 16:32:24  daniel
    * copyright 2000 added

}
