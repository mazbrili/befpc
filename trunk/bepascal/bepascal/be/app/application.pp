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

unit Application;

interface

uses
  beobj, looper, appdefs, supportdefs, message, os;

type
  TApplication = class(TLooper)
  private
  public
    constructor Create; override;
    constructor Create(Signature : PChar); virtual;
	constructor Create(Signature : PChar; error : PStatus_t); virtual;
    destructor Destroy; override;
    procedure ShowCursor;
    procedure HideCursor;
    function Run : TThread_id;
    procedure Quit;
      // Hook functions
    procedure AppActivated(Active : boolean); virtual;
    procedure ReadyToRun; virtual;
  end;

function BApplication_Create(AObject : TObject) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_1';
function BApplication_Create(AObject : TObject; Signature : PChar) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_2';
function BApplication_Create(AObject : TObject; Signature : PChar; error : PStatus_t) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_3';
procedure BApplication_Free(Application : TCPlusObject); cdecl; external BePascalLibName;
procedure BApplication_HideCursor(Application : TCPlusObject); cdecl; external BePascalLibName;
procedure BApplication_ShowCursor(Application : TCPlusObject); cdecl; external BePascalLibName;
function BApplication_Run(Application : TCPlusObject) : TThread_id; cdecl; external BePascalLibName;
procedure BApplication_Quit(Application : TCPlusObject); cdecl; external BePascalLibName;

var
  be_app : TApplication;

implementation

var
  Application_AppActivated_hook : Pointer; cvar; external;
  Application_ReadyToRun_hook : Pointer; cvar; external;

  // start TApplication
constructor TApplication.Create;
begin
  inherited;
  CPlusObject := BApplication_Create(Self, PChar('application/x-vnd.BePascal'));  
  be_app := Self;
end;

constructor TApplication.Create(Signature : PChar);
begin
  inherited Create;	
  CPlusObject := BApplication_Create(Self, Signature);  
  be_app := Self;
end;

constructor TApplication.Create(Signature : PChar; error : PStatus_t);
begin
  inherited Create;	
  CPlusObject := BApplication_Create(Self, Signature, error);  
  be_app := Self;
end;

destructor TApplication.Destroy;
begin
  if CPlusObject <> nil then
    BApplication_Free(CPlusObject);
  inherited;
end;

// Hook functions

procedure Application_AppActivated_hook_func(Application : TApplication; Active : boolean); cdecl;
begin
  if Application <> nil then
    Application.AppActivated(Active);
end;

procedure TApplication.AppActivated(Active : boolean);
begin
{$IFDEF DEBUG}
  WriteLn(Active);
  if Active then
	WriteLn('Application activée !')
  else
    WriteLn('Application désactivée !');
{$ENDIF}
end;

procedure Application_ReadyToRun_hook_func(Application : TApplication); cdecl;
begin
{$IFDEF DEBUG}
  WriteLn('Hook ReadyToRun !');
{$ENDIF}
  if Application <> nil then
    Application.ReadyToRun;
end;

procedure Application_MessageReceived_hook_func(Application : TApplication; aMessage : TCPlusObject); cdecl;
var
  Message : TMessage;
begin
{$IFDEF DEBUG}
  WriteLn('Hook MessageReceived !');
{$ENDIF}
  Message := TMessage.Wrap(aMessage);
  try
    if Application <> nil then
      Application.MessageReceived(Message);
  finally
    Message.UnWrap;
  end;
end;

procedure TApplication.ReadyToRun;
begin
{$IFDEF DEBUG}
  WriteLn('Prêt à démarer !');
{$ENDIF}
end;

procedure TApplication.ShowCursor;
begin
  BApplication_ShowCursor(CPlusObject);
end;

procedure TApplication.HideCursor;
begin
  BApplication_HideCursor(CPlusObject);
end;

function TApplication.Run : TThread_id;
begin
  Result := BApplication_Run(CPlusObject);
end;

procedure TApplication.Quit;
begin
	BApplication_Quit(CPlusObject);
end;

  // end TApplication
  
initialization
  be_app := nil;
  Application_AppActivated_hook := @Application_AppActivated_hook_func;
  Application_ReadyToRun_hook := @Application_ReadyToRun_hook_func;
  
finalization
  Application_AppActivated_hook := nil;
  Application_ReadyToRun_hook := nil;
  be_app := nil;
  
end.