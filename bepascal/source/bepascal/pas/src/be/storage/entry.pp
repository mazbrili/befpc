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

unit entry;

interface

uses
  beobj, storagedefs,SupportDefs;

type
  EntryRef = record
    device : dev_t;
    directory : ino_t;
    name : PChar;
  end;  
  PEntryRef =^EntryRef;  
type
  BEntry = class(TBeObject)
  private
  public
    constructor Create;
//    constructor Create(dir : BDirectory; path : PChar; traverse : boolean);
    constructor Create(ref : EntryRef; traverse : boolean);
    constructor Create(path : PChar; traverse : boolean);
    constructor Create(entry : BEntry);
    destructor Destroy;override;
    function InitCheck : Status_t;
    function Exists : boolean;
//    function GetStat(st : stat) : Status_t;
//    function SetTo(dir : BDirectory; path : PChar; traverse : boolean) : Status_t;
    function SetTo(ref : EntryRef; traverse : boolean) : Status_t;
    function SetTo(path : PChar; traverse : boolean) : Status_t;
    procedure Unset;
    function GetRef(ref : EntryRef) : Status_t;
//    function GetPath(path : BPath) : Status_t;
    function GetParent(entry : BEntry) : Status_t;
//    function GetParent(dir : BDirectory) : Status_t;
    function GetName( var buffer : PChar) : Status_t;
    function Rename(path : PChar; clobber : boolean) : Status_t;
//    function MoveTo(dir : BDirectory; path : PChar; clobber : boolean) : Status_t;
    function Remove : Status_t;
  end;

function BEntry_Create(AObject : TBeObject):TCPlusObject; cdecl; external BePascalLibName name 'BEntry_Create';
//function BEntry_Create(AObject : TBeObject; dir : BDirectory; path : PChar; traverse : boolean); cdecl; external BePascalLibName name 'BEntry_Create';
function BEntry_Create(AObject : TBeObject; ref : EntryRef; traverse : boolean):TCPlusObject; cdecl; external BePascalLibName name 'BEntry_Create';
function BEntry_Create(AObject : TBeObject; path : PChar; traverse : boolean):TCPlusObject; cdecl; external BePascalLibName name 'BEntry_Create';
function BEntry_Create(AObject : TBeObject; entry : BEntry):TCPlusObject; cdecl; external BePascalLibName name 'BEntry_Create';
procedure BEntry_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BEntry_Free';
function BEntry_InitCheck(AObject : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BEntry_InitCheck';
function BEntry_Exists(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BEntry_Exists';
//function BEntry_GetStat(AObject : TCPlusObject; st : stat) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetStat';
//function BEntry_SetTo(AObject : TCPlusObject; dir : BDirectory; path : PChar; traverse : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BEntry_SetTo';
function BEntry_SetTo(AObject : TCPlusObject; ref : EntryRef; traverse : boolean) : Status_t; cdecl; external BePascalLibName name 'BEntry_SetTo';
function BEntry_SetTo(AObject : TCPlusObject; path : PChar; traverse : boolean) : Status_t; cdecl; external BePascalLibName name 'BEntry_SetTo';
procedure BEntry_Unset(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BEntry_Unset';
function BEntry_GetRef(AObject : TCPlusObject; ref : EntryRef) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetRef';
//function BEntry_GetPath(AObject : TCPlusObject; path : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetPath';
function BEntry_GetParent(AObject : TCPlusObject; entry : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetParent';
//function BEntry_GetParent(AObject : TCPlusObject; dir : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetParent';
function BEntry_GetName(AObject : TCPlusObject; buffer : PChar) : Status_t; cdecl; external BePascalLibName name 'BEntry_GetName';
function BEntry_Rename(AObject : TCPlusObject; path : PChar; clobber : boolean) : Status_t; cdecl; external BePascalLibName name 'BEntry_Rename';
function BEntry_MoveTo(AObject : TCPlusObject; dir : TCPlusObject; path : PChar; clobber : boolean) : Status_t; cdecl; external BePascalLibName name 'BEntry_MoveTo';
function BEntry_Remove(AObject : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BEntry_Remove';

implementation


constructor BEntry.Create;
begin
  CreatePas;
  CPlusObject := BEntry_Create(Self);
end;

{constructor BEntry.Create(dir : BDirectory; path : PChar; traverse : boolean);
begin
  CPlusObject := BEntry_Create(Self, dir, path, traverse);
end;
}
constructor BEntry.Create(ref : EntryRef; traverse : boolean);
begin
  CreatePas;
  CPlusObject := BEntry_Create(Self, ref, traverse);
end;

constructor BEntry.Create(path : PChar; traverse : boolean);
begin
  CreatePas;
  CPlusObject := BEntry_Create(Self, path, traverse);
end;

constructor BEntry.Create(entry : BEntry);
begin
  CreatePas;
  CPlusObject := BEntry_Create(Self, entry);
end;

destructor BEntry.Destroy;
begin
  BEntry_Free(CPlusObject);
  inherited;
end;

function BEntry.InitCheck : Status_t;
begin
  Result := BEntry_InitCheck(CPlusObject);
end;

function BEntry.Exists : boolean;
begin
  Result := BEntry_Exists(CPlusObject);
end;

{function BEntry.GetStat(st : stat) : Status_t;
begin
  Result := BEntry_GetStat(CPlusObject, st);
end;
}
{function BEntry.SetTo(dir : BDirectory; path : PChar; traverse : boolean) : TStatus_t;
begin
  Result := BEntry_SetTo(CPlusObject, dir, path, traverse);
end;
}
function BEntry.SetTo(ref : EntryRef; traverse : boolean) : Status_t;
begin
  Result := BEntry_SetTo(CPlusObject, ref, traverse);
end;

function BEntry.SetTo(path : PChar; traverse : boolean) : Status_t;
begin
  Result := BEntry_SetTo(CPlusObject, path, traverse);
end;

procedure BEntry.Unset;
begin
  BEntry_Unset(CPlusObject);
end;

function BEntry.GetRef(ref : EntryRef) : Status_t;
begin
  Result := BEntry_GetRef(CPlusObject, ref);
end;

{function BEntry.GetPath(path : BPath) : Status_t;
begin
  Result := BEntry_GetPath(CPlusObject, path.CPlusObject);
end;
}
function BEntry.GetParent(entry : BEntry) : Status_t;
begin
  Result := BEntry_GetParent(CPlusObject, entry.CPlusObject);
end;

{function BEntry.GetParent(dir : BDirectory) : TStatus_t;
begin
  Result := BEntry_GetParent(CPlusObject, dir.CPlusObject);
end;
}
function BEntry.GetName(var buffer : PChar) : Status_t;
begin
  Result := BEntry_GetName(CPlusObject, buffer);
end;

function BEntry.Rename(path : PChar; clobber : boolean) : Status_t;
begin
  Result := BEntry_Rename(CPlusObject, path, clobber);
end;

{function BEntry.MoveTo(dir : BDirectory; path : PChar; clobber : boolean) : TStatus_t;
begin
  Result := BEntry_MoveTo(CPlusObject, dir.CPlusObject, path, clobber);
end;
}
function BEntry.Remove : Status_t;
begin
  Result := BEntry_Remove(CPlusObject);
end;



end.
