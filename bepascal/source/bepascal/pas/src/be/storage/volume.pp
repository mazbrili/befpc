{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Eric Jourde

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

unit Volume;

interface

uses
  beobj, SupportDefs, os;

type
	BVolume = class(TBeObject)
	public
  		constructor Create; override;
		destructor Destroy; override;

		function InitCheck : Status_t;	  		
		function SetTo(dev : Dev_t) : Status_t;	  		
		procedure Unset;
		function Device : Dev_t;
		function Capacity : Off_t;
		function FreeBytes : Off_t;
		function GetName( name : pchar ):Status_t;
		function SetName( name : pchar ):Status_t;
		function IsRemovable : boolean;
		function IsReadOnly : boolean;
		function IsPersistent : boolean;
		function IsShared : boolean;
		function KnowsMime : boolean;
		function KnowsAttr : boolean;
		function KnowsQuery : boolean;
		
	end;


function BVolume_Create: TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create';
function BVolume_Create_1(dev :Dev_t ): TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create_1';
function BVolume_Create_2(vol : TCPlusObject ): TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create_2';
procedure BVolume_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BVolume_BVolume';

function  BVolume_InitCheck(AObject : TCPlusObject) : Status_t;cdecl; external BePascalLibName name 'BVolume_InitCheck';
function   BVolume_SetTo(AObject : TCPlusObject; dev :Dev_t ): Status_t;cdecl; external BePascalLibName name 'BVolume_SetTo';
procedure BVolume_Unset(AObject : TCPlusObject);cdecl; external BePascalLibName name 'BVolume_Unset';
function BVolume_Device(AObject : TCPlusObject) : Dev_t;cdecl; external BePascalLibName name 'BVolume_Device';
//status_t BVolume_GetRootDirectory(BVolume *Volume, BDirectory *dir) 
function BVolume_Capacity(AObject : TCPlusObject) : Off_t;cdecl; external BePascalLibName name 'BVolume_Capacity';
function BVolume_FreeBytes(AObject : TCPlusObject) : Off_t;cdecl; external BePascalLibName name 'BVolume_FreeBytes';
function   BVolume_GetName(AObject : TCPlusObject; name : pchar ): Status_t;cdecl; external BePascalLibName name 'BVolume_GetName';
function   BVolume_SetName(AObject : TCPlusObject; name : pchar ): Status_t;cdecl; external BePascalLibName name 'BVolume_SetName';
//status_t BVolume_GetIcon(BVolume *Volume, BBitmap *icon, icon_size which) 
function  BVolume_IsRemovable(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsRemovable';

function  BVolume_IsReadOnly(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsReadOnly';
function  BVolume_IsPersistent(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsPersistent';
function  BVolume_IsShared(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsShared';
function  BVolume_KnowsMime(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsMime';
function  BVolume_KnowsAttr(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsAttr';
function  BVolume_KnowsQuery(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsQuery';




implementation

constructor BVolume.Create;
begin
	inherited;
	CPlusObject:=BVolume_Create;
end;

  		
destructor BVolume.Destroy;
begin
	if CPlusObject <> nil then  BVolume_Free(CPlusObject);
	inherited;	
end;

function BVolume.InitCheck: Status_t;
begin
	result:=BVolume_InitCheck(CPlusObject);
end;

function BVolume.SetTo(dev : Dev_t) : Status_t;	  		
begin
 	result:=BVolume_SetTo(CPlusObject,dev);
end;

procedure BVolume.Unset;
begin
	BVolume_Unset(CPlusObject);
end;

function BVolume.Device : Dev_t;
begin
	result:=BVolume_Device(CPlusObject);
end;

function BVolume.Capacity : Off_t;
begin
	result:=BVolume_Capacity(CPlusObject);
end;

function BVolume.FreeBytes : Off_t;
begin
	result:=BVolume_FreeBytes(CPlusObject);
end;
  		
function BVolume.GetName( name : pchar ):Status_t;
begin
	result:=BVolume_GetName(CPlusObject,name);
end;

function BVolume.SetName( name : pchar ):Status_t;
begin
	result:=BVolume_SetName(CPlusObject,name);
end;
 		
function BVolume.IsRemovable : boolean;
begin
	result:=BVolume_IsRemovable(CPlusObject);
end;

function BVolume.IsReadOnly : boolean;
begin
	result:=BVolume_IsReadOnly(CPlusObject);
end;

function BVolume.IsPersistent : boolean;
begin
	result:=BVolume_IsPersistent(CPlusObject);
end;

function BVolume.IsShared : boolean;
begin
	result:=BVolume_IsShared(CPlusObject);
end;

function BVolume.KnowsMime : boolean;
begin
	result:=BVolume_KnowsMime(CPlusObject);
end;

function BVolume.KnowsAttr : boolean;
begin
	result:=BVolume_KnowsAttr(CPlusObject);
end;

function BVolume.KnowsQuery : boolean;
begin
	result:=BVolume_KnowsQuery(CPlusObject);
end;

  		
end.
