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
	TVolume = class(TBeObject)
	public
  		constructor Create; override;
		destructor Destroy; override;

		function InitCheck : Tstatus_t;	  		
		function SetTo(dev : Tdev_t) : Tstatus_t;	  		
		procedure Unset;
		function Device : Tdev_t;
		function Capacity : Toff_t;
		function FreeBytes : Toff_t;
		function GetName( name : pchar ):Tstatus_t;
		function SetName( name : pchar ):Tstatus_t;
		function IsRemovable : boolean;
		function IsReadOnly : boolean;
		function IsPersistent : boolean;
		function IsShared : boolean;
		function KnowsMime : boolean;
		function KnowsAttr : boolean;
		function KnowsQuery : boolean;
		
	end;


function BVolume_Create: TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create';
function BVolume_Create_1(dev :Tdev_t ): TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create_1';
function BVolume_Create_2(vol : TCPlusObject ): TCPlusObject;cdecl; external BePascalLibName name 'BVolume_Create_2';
procedure BVolume_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BVolume_BVolume';

function  BVolume_InitCheck(AObject : TCPlusObject) : Tstatus_t;cdecl; external BePascalLibName name 'BVolume_InitCheck';
function   BVolume_SetTo(AObject : TCPlusObject; dev :Tdev_t ): Tstatus_t;cdecl; external BePascalLibName name 'BVolume_SetTo';
procedure BVolume_Unset(AObject : TCPlusObject);cdecl; external BePascalLibName name 'BVolume_Unset';
function BVolume_Device(AObject : TCPlusObject) : TDev_t;cdecl; external BePascalLibName name 'BVolume_Device';
//status_t BVolume_GetRootDirectory(BVolume *Volume, BDirectory *dir) 
function BVolume_Capacity(AObject : TCPlusObject) : Toff_t;cdecl; external BePascalLibName name 'BVolume_Capacity';
function BVolume_FreeBytes(AObject : TCPlusObject) : Toff_t;cdecl; external BePascalLibName name 'BVolume_FreeBytes';
function   BVolume_GetName(AObject : TCPlusObject; name : pchar ): Tstatus_t;cdecl; external BePascalLibName name 'BVolume_GetName';
function   BVolume_SetName(AObject : TCPlusObject; name : pchar ): Tstatus_t;cdecl; external BePascalLibName name 'BVolume_SetName';
//status_t BVolume_GetIcon(BVolume *Volume, BBitmap *icon, icon_size which) 
function  BVolume_IsRemovable(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsRemovable';

function  BVolume_IsReadOnly(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsReadOnly';
function  BVolume_IsPersistent(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsPersistent';
function  BVolume_IsShared(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_IsShared';
function  BVolume_KnowsMime(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsMime';
function  BVolume_KnowsAttr(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsAttr';
function  BVolume_KnowsQuery(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BVolume_KnowsQuery';




implementation

constructor TVolume.Create;
begin
	inherited;
	CPlusObject:=BVolume_Create;
end;

  		
destructor TVolume.Destroy;
begin
	if CPlusObject <> nil then  BVolume_Free(CPlusObject);
	inherited;	
end;

function TVolume.InitCheck: Tstatus_t;
begin
	result:=BVolume_InitCheck(CPlusObject);
end;

function TVolume.SetTo(dev : Tdev_t) : Tstatus_t;	  		
begin
 	result:=BVolume_SetTo(CPlusObject,dev);
end;

procedure TVolume.Unset;
begin
	BVolume_Unset(CPlusObject);
end;

function TVolume.Device : Tdev_t;
begin
	result:=BVolume_Device(CPlusObject);
end;

function TVolume.Capacity : Toff_t;
begin
	result:=BVolume_Capacity(CPlusObject);
end;

function TVolume.FreeBytes : Toff_t;
begin
	result:=BVolume_FreeBytes(CPlusObject);
end;
  		
function TVolume.GetName( name : pchar ):Tstatus_t;
begin
	result:=BVolume_GetName(CPlusObject,name);
end;

function TVolume.SetName( name : pchar ):Tstatus_t;
begin
	result:=BVolume_SetName(CPlusObject,name);
end;
 		
function TVolume.IsRemovable : boolean;
begin
	result:=BVolume_IsRemovable(CPlusObject);
end;

function TVolume.IsReadOnly : boolean;
begin
	result:=BVolume_IsReadOnly(CPlusObject);
end;

function TVolume.IsPersistent : boolean;
begin
	result:=BVolume_IsPersistent(CPlusObject);
end;

function TVolume.IsShared : boolean;
begin
	result:=BVolume_IsShared(CPlusObject);
end;

function TVolume.KnowsMime : boolean;
begin
	result:=BVolume_KnowsMime(CPlusObject);
end;

function TVolume.KnowsAttr : boolean;
begin
	result:=BVolume_KnowsAttr(CPlusObject);
end;

function TVolume.KnowsQuery : boolean;
begin
	result:=BVolume_KnowsQuery(CPlusObject);
end;

  		
end.
