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

unit volumeroster;

interface

uses
  beobj, SupportDefs, os , Volume;
  
type
  BVolumeRoster = class(TBeObject)
  private
  public
	constructor Create; override;
  	destructor Destroy; override;
	
	function GetNextVolume(val : TVolume): Status_t;
	procedure Rewind;
	function GetBootVolume( vol: TVolume ):Status_t;
	//function StartWatching( msngr : TMessenger): Status_t;
	procedure StopWatching;
  end;


function BVolumeRoster_Create(AObject : TBeObject): TCPlusObject;cdecl; external BePascalLibName name 'BVolumeRoster_Create';
procedure BVolumeRoster_Free(AObject : TCPlusObject);cdecl; external BePascalLibName name 'BVolumeRoster_Free';

function BVolumeRoster_GetNextVolume(AObject : TCPlusObject;vol : TCPlusObject): Status_t;cdecl; external BePascalLibName name 'BVolumeRoster_GetNextVolume';
procedure BVolumeRoster_Rewind(AObject : TCPlusObject);cdecl; external BePascalLibName name 'BVolumeRoster_Rewind';
function BVolumeRoster_GetBootVolume(AObject : TCPlusObject; vol: TCPlusObject ):Status_t;cdecl; external BePascalLibName name 'BVolumeRoster_GetBootVolume';
//function BVolumeRoster_StartWatching(AObject : TCPlusObject;  msngr : TMessenger): Status_t;cdecl; external BePascalLibName name 'BVolumeRoster_StartWatching';
procedure BVolumeRoster_StopWatching(AObject : TCPlusObject);cdecl; external BePascalLibName name 'BVolumeRoster_StopWatching';


  
  
implementation


constructor BVolumeRoster.Create; 
begin
  inherited;
  CPlusObject := BVolumeRoster_Create(Self);
end;

destructor BVolumeRoster.Destroy; 
begin
  if CPlusObject <> nil then
    BVolumeRoster_Free(CPlusObject);
  inherited;

end;

function BVolumeRoster.GetNextVolume(val : TVolume): Status_t;
begin
  result:=BVolumeRoster_GetNextVolume(CPlusObject,val.CPlusObject);
end;

procedure BVolumeRoster.Rewind;
begin
  BVolumeRoster_Rewind(CPlusObject);
end;

function BVolumeRoster.GetBootVolume( vol: TVolume ):Status_t;
begin
  result:=BVolumeRoster_GetBootVolume(CPlusObject,vol.CPlusObject);
end;

//function BVolumeRoster.StartWatching( msngr : TMessenger): Status_t;
//begin
//  result:=BVolumeRoster_StartWatching(CPlusObject,msngr);
//end;

procedure BVolumeRoster.StopWatching;
begin
  BVolumeRoster_StopWatching(CPlusObject);
end;

end.
