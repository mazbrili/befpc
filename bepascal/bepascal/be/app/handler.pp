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

unit handler;

interface

uses
  beobj, archivable, message;
 
type
  THandler = class(TArchivable)
  public
    procedure MessageReceived(aMessage : TMessage); virtual;  
  end;
  
implementation

uses
  SysUtils;
  
var
  Handler_MessageReceived_hook : Pointer; cvar; external;
  
procedure THandler.MessageReceived(aMessage : TMessage);
begin
{$IFDEF DEBUG}
  WriteLn(ClassName + '.MessageReceived');
  WriteLn('Message reçue');
  aMessage.PrintToStream;
{$ENDIF}
end;

procedure Handler_MessageReceived_hook_func(Handler : THandler; aMessage : TCPlusObject); cdecl;
var
  Message : TMessage;
begin
  try
{$IFDEF DEBUG}
    WriteLn('Hook MessageReceived !');
{$ENDIF}
    Message := TMessage.Wrap(aMessage);
    try
      if Handler <> nil then
        Handler.MessageReceived(Message);
    finally
      Message.UnWrap;
    end;
  except
    on e : exception do
    begin
{$IFDEF DEBUG}
      WriteLn(e.Message + 'Handler_MessageReceived');
{$ENDIF}
    end;
  end
end;

initialization
  Handler_MessageReceived_hook := @Handler_MessageReceived_hook_func;
  
finalization
  Handler_MessageReceived_hook := nil;
	
end.