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

unit looper;

interface

uses
  beobj, handler, message, os, SupportDefs;

const
  B_LOOPER_PORT_DEFAULT_CAPACITY = 100;
  
type
  TLooper = class(THandler)
  private
  public
    procedure DispatchMessage(aMessage : TMessage; aTarget : THandler); virtual;
    function QuitRequested() : boolean; virtual;
    function GetSupportedSuites(aMessage : TMessage) : TStatus_t;
    function PostMessage(command : Cardinal) : TStatus_t;
  end;

//function BLooper_Create(AObject : TObject);
function BLooper_GetSupportedSuites(Looper : TCplusObject; aMessage : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BLooper_GetSupportedSuites';
function BLooper_PostMessage(Looper : TCPlusObject; command : Cardinal) : TStatus_t; cdecl; external BePascalLibName  name 'BLooper_PostMessage_2';

implementation

var
  Looper_DispatchMessage_hook : Pointer; cvar; external;
  Looper_QuitRequested_hook : Pointer; cvar; external;

procedure TLooper.DispatchMessage(aMessage : TMessage; aTarget : THandler);
begin
end;

function TLooper.QuitRequested() : boolean;
begin
  Result := True;
end;

function TLooper.GetSupportedSuites(aMessage : TMessage) : TStatus_t;
begin
  result := BLooper_GetSupportedSuites(CPlusObject, aMessage.CPlusObject);    
end;

function TLooper.PostMessage(command : Cardinal) : TStatus_t;
begin
  result := BLooper_PostMessage(CPlusObject, command);
end;

// hooks

procedure Looper_DispatchMessage_hook_func(Looper : TLooper; 
  aMessage : TCPlusObject; aTarget : TCPlusObject); cdecl;
var
  Message : TMessage;
  Target : THandler;
begin
  Message := TMessage.Wrap(aMessage);
  try
    Target := THandler.Wrap(aTarget);
    try
      Looper.DispatchMessage(Message, Target);
    finally
      Target.UnWrap;
    end;
  finally
    Message.UnWrap;
  end;
end;

function Looper_QuitRequested_hook_func(Looper : TLooper) : boolean; cdecl;
begin
  if Looper <> nil then
    Result := Looper.QuitRequested();
end;

initialization
  Looper_DispatchMessage_hook := @Looper_DispatchMessage_hook_func;
  Looper_QuitRequested_hook := @Looper_QuitRequested_hook_func;

finalization
  Looper_DispatchMessage_hook := nil;
  Looper_QuitRequested_hook := nil;

end.