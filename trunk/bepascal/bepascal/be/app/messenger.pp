{   BePascal - A pascal wrapper around the BeOS API                             
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
unit messenger;

interface

uses
  beobj, os, Handler, Looper, Message, SupportDefs;

type
  TMessenger = class(TBeObject)
  private
  public
    constructor Create; override;
    constructor Create(mime_sig : PChar; aTeam : TTeam_id; perr : PStatus_t); 
    constructor Create(handler : THandler; looper : TLooper; perr : PStatus_t);
    constructor Create(from : TMessenger);
    destructor Destroy; override;
    function IsTargetLocal : boolean;
    function Target(looper : TLooper) : THandler;
    function LockTarget : boolean;
//    function LockTargetWithTimeout(timeout : TBigtime_t) : TStatus_t;
    function SendMessage(command : Cardinal; reply_to : THandler) : TStatus_t;
    function SendMessage(a_message : TMessage; reply_to : THandler; timeout : TBigtime_t) : TStatus_t;
    function SendMessage(a_message : TMessage; reply_to : TMessenger; timeout : TBigtime_t) : TStatus_t;
    function SendMessage(command : Cardinal; reply : TMessage) : TStatus_t;
    function SendMessage(a_message : TMessage; reply : TMessage; send_timeout : TBigtime_t; reply_timeout : TBigtime_t) : TStatus_t;
//    function operator=(from : TMessenger) : TMessenger;
//    function operator==(other : TMessenger) : boolean;
    function IsValid : boolean;
    function Team : TTeam_id;
//    constructor Create(aTeam : TTeam_id; port : TPort_id; token : integer; preferred : boolean);
//    procedure InitData(mime_sig : PChar; aTeam : TTeam_id; perr : PStatus_t);
//    procedure port_id fPort;
//    procedure int32 fHandlerToken;
//    procedure team_id fTeam;
//    procedure int32 extra0;
//    procedure int32 extra1;
//    procedure bool fPreferredTarget;
//    procedure bool extra2;
//    procedure bool extra3;
//    procedure bool extra4;
  end;

function BMessenger_Create(AObject : TBeObject) : TCplusObject; cdecl; external BePascalLibName name 'BMessenger_Create';
function BMessenger_Create(AObject : TBeObject; mime_sig : PChar; team : TTeam_id; perr : PStatus_t) : TCplusObject; cdecl; external BePascalLibName name 'BMessenger_Create_1';
function BMessenger_Create(AObject : TBeObject; handler : THandler; looper : TLooper; perr : PStatus_t) : TCplusObject; cdecl; external BePascalLibName name 'BMessenger_Create_2';
function BMessenger_Create(AObject : TBeObject; from : TMessenger) : TCplusObject; cdecl; external BePascalLibName name 'BMessenger_Create_3';
procedure BMessenger_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_Free';
function BMessenger_IsTargetLocal(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMessenger_IsTargetLocal';
function BMessenger_Target(AObject : TCPlusObject; looper : TCplusObject) : THandler; cdecl; external BePascalLibName name 'BMessenger_Target';
function BMessenger_LockTarget(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMessenger_LockTarget';
//function BMessenger_LockTargetWithTimeout(AObject : TCPlusObject; timeout : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_LockTargetWithTimeout';
function BMessenger_SendMessage(AObject : TCPlusObject; command : Cardinal; reply_to : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_SendMessage';
function BMessenger_SendMessage_1(AObject : TCPlusObject; a_message : TCplusObject; reply_to : TCplusObject; timeout : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_SendMessage_1';
// How to handle this ? (remove the comment to see what to fix)
function BMessenger_SendMessage_2(AObject : TCPlusObject; a_message : TCplusObject; reply_to : TCplusObject; timeout : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_SendMessage_2';
function BMessenger_SendMessage_3(AObject : TCPlusObject; command : Cardinal; reply : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_SendMessage_3';
function BMessenger_SendMessage_4(AObject : TCPlusObject; a_message : TCplusObject; reply : TCplusObject; send_timeout : TBigtime_t; reply_timeout : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BMessenger_SendMessage_4';
//function BMessenger_operator=(AObject : TCPlusObject; from : TMessenger) : TMessenger; cdecl; external BePascalLibName name 'BMessenger_operator=';
//function BMessenger_operator==(AObject : TCPlusObject; other : TMessenger) : boolean; cdecl; external BePascalLibName name 'BMessenger_operator==';
function BMessenger_IsValid(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMessenger_IsValid';
function BMessenger_Team(AObject : TCPlusObject) : TTeam_id; cdecl; external BePascalLibName name 'BMessenger_Team';
//function BMessenger_Create(AObject : TBeObject; team : TTeam_id; port : TPort_id; token : integer; preferred : boolean) : TCplusObject; cdecl; external BePascalLibName name 'BMessenger_Create';
//procedure BMessenger_InitData(AObject : TCPlusObject; mime_sig : PChar; team : TTeam_id; perr : PStatus_t); cdecl; external BePascalLibName name 'BMessenger_InitData';
//procedure BMessenger_port_id fPort(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_port_id fPort';
//procedure BMessenger_int32 fHandlerToken(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_int32 fHandlerToken';
//procedure BMessenger_team_id fTeam(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_team_id fTeam';
//procedure BMessenger_int32 extra0(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_int32 extra0';
//procedure BMessenger_int32 extra1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_int32 extra1';
//procedure BMessenger_bool fPreferredTarget(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_bool fPreferredTarget';
//procedure BMessenger_bool extra2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_bool extra2';
//procedure BMessenger_bool extra3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_bool extra3';
//procedure BMessenger_bool extra4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMessenger_bool extra4';

var
  be_app_messenger : TMessenger;
  
implementation

constructor TMessenger.Create;
begin
  BMessenger_Create(Self);
end;

constructor TMessenger.Create(mime_sig : PChar; aTeam : TTeam_id; perr : PStatus_t);
begin
  CPlusObject := BMessenger_Create(Self, mime_sig, aTeam, perr);
end;

constructor TMessenger.Create(handler : THandler; looper : TLooper; perr : PStatus_t);
begin
  CPlusObject := BMessenger_Create(Self, handler, looper, perr);
end;

constructor TMessenger.Create(from : TMessenger);
begin
  CPlusObject := BMessenger_Create(Self, from);
end;

destructor TMessenger.Destroy;
begin
  BMessenger_Free(CPlusObject);
end;

function TMessenger.IsTargetLocal : boolean;
begin
  Result := BMessenger_IsTargetLocal(CPlusObject);
end;

function TMessenger.Target(looper : TLooper) : THandler;
begin
  Result := BMessenger_Target(CPlusObject, looper.CPlusObject);
end;

function TMessenger.LockTarget : boolean;
begin
  Result := BMessenger_LockTarget(CPlusObject);
end;

//function TMessenger.LockTargetWithTimeout(timeout : TBigtime_t) : TStatus_t;
//begin
//  BMessenger_LockTargetWithTimeout(CPlusObject, timeout);
//end;

function TMessenger.SendMessage(command : Cardinal; reply_to : THandler) : TStatus_t;
begin
  Result := BMessenger_SendMessage(CPlusObject, command, reply_to.CPlusObject);
end;

function TMessenger.SendMessage(a_message : TMessage; reply_to : THandler; timeout : TBigtime_t) : TStatus_t;
begin
  Result := BMessenger_SendMessage_1(CPlusObject, a_message.CPlusObject, reply_to.CPlusObject, timeout);
end;

function TMessenger.SendMessage(a_message : TMessage; reply_to : TMessenger; timeout : TBigtime_t) : TStatus_t;
begin
  Result := BMessenger_SendMessage_2(CPlusObject, a_message.CPlusObject, reply_to.CPlusObject, timeout);
end;

function TMessenger.SendMessage(command : Cardinal; reply : TMessage) : TStatus_t;
begin
  Result := BMessenger_SendMessage_3(CPlusObject, command, reply.CPlusObject);
end;

function TMessenger.SendMessage(a_message : TMessage; reply : TMessage; send_timeout : TBigtime_t; reply_timeout : TBigtime_t) : TStatus_t;
begin
  Result := BMessenger_SendMessage_4(CPlusObject, a_message.CPlusObject, reply.CPlusObject, send_timeout, reply_timeout);
end;

//function TMessenger.operator=(from : TMessenger) : TMessenger;
//begin
//  BMessenger_operator=(CPlusObject, from);
//end;
//
//function TMessenger.operator==(other : TMessenger) : boolean;
//begin
//  BMessenger_operator==(CPlusObject, other);
//end;

function TMessenger.IsValid : boolean;
begin
  Result := BMessenger_IsValid(CPlusObject);
end;

function TMessenger.Team : TTeam_id;
begin
  Result := BMessenger_Team(CPlusObject);
end;

//constructor TMessenger.Create(aTeam : TTeam_id; port : TPort_id; token : integer; preferred : boolean);
//begin
//  CPlusObject := BMessenger_Create(Self, aTeam, port, token, preferred);
//end;

//procedure TMessenger.InitData(mime_sig : PChar; aTeam : TTeam_id; perr : PStatus_t);
//begin
//  BMessenger_InitData(CPlusObject, mime_sig, aTeam, perr);
//end;

//procedure TMessenger.port_id fPort;
//begin
//  BMessenger_port_id fPort(CPlusObject);
//end;
//
//procedure TMessenger.int32 fHandlerToken;
//begin
//  BMessenger_int32 fHandlerToken(CPlusObject);
//end;
//
//procedure TMessenger.team_id fTeam;
//begin
//  BMessenger_team_id fTeam(CPlusObject);
//end;
//
//procedure TMessenger.int32 extra0;
//begin
//  BMessenger_int32 extra0(CPlusObject);
//end;
//
//procedure TMessenger.int32 extra1;
//begin
//  BMessenger_int32 extra1(CPlusObject);
//end;
//
//procedure TMessenger.bool fPreferredTarget;
//begin
//  BMessenger_bool fPreferredTarget(CPlusObject);
//end;
//
//procedure TMessenger.bool extra2;
//begin
//  BMessenger_bool extra2(CPlusObject);
//end;
//
//procedure TMessenger.bool extra3;
//begin
//  BMessenger_bool extra3(CPlusObject);
//end;
//
//procedure TMessenger.bool extra4;
//begin
//  BMessenger_bool extra4(CPlusObject);
//end;

initialization
  be_app_messenger := nil;

finalization
	be_app_messenger := nil;

end.
