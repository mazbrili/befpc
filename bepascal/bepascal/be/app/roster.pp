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

unit Roster;

interface

uses
  beobj, appdefs, supportdefs,
  message;
  
type
  TRoster = class(TBeObject)
  private
  public
  	constructor Create; override;
  	destructor Destroy; override;
  	function Broadcast(aMessage : TMessage) : TStatus_t;
  end;
  
function Get_be_roster : TCPlusObject; cdecl; external BePascalLibName;
function BRoster_Create(AObject : TObject) : TCPlusObject; cdecl; external BePascalLibName;
procedure BRoster_Destroy(CPlusObject : TCPlusObject); cdecl; external BePascalLibName;
function BRoster_Broadcast(aRoster : TCPlusObject; aMessage : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName;
  
var
  be_roster : TRoster;
  
implementation

constructor TRoster.Create;
begin
  inherited;
  CPlusObject := BRoster_Create(Self);
  be_roster := Self;
end;

destructor TRoster.Destroy;
begin
  BRoster_Destroy(CPlusObject);
  inherited;
end;

function TRoster.Broadcast(aMessage : TMessage) : TStatus_t;
begin
  result := BRoster_Broadcast(Self.CPlusObject, aMessage.CPlusObject);
end;

initialization
  be_roster := TRoster.Wrap(Get_be_roster);

finalization
  be_roster.UnWrap;
  be_roster := nil;
end.