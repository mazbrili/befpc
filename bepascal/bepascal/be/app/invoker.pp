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
unit invoker;

interface

uses
  beobj, Message, Handler, Looper, SupportDefs, Messenger;

type
  TInvoker = class(TBeObject)
  private
  public
    constructor Create; override;
    constructor Create(aMessage : TMessage; handler : THandler; looper : TLooper);
    constructor Create(aMessage : TMessage; aTarget : TMessenger);
    destructor Destroy; override;
    function SetMessage(aMessage : TMessage) : TStatus_t;
    function Message : TMessage;
    function Command : Cardinal;
    function SetTarget(h : THandler; loop : TLooper) : TStatus_t;
    function SetTarget(aMessenger : TMessenger) : TStatus_t;
    function IsTargetLocal : boolean;
    function Target(looper : TLooper) : THandler;
    function Messenger : TMessenger;
    function SetHandlerForReply(handler : THandler) : TStatus_t;
    function HandlerForReply : THandler;
    function Invoke(msg : TMessage) : TStatus_t;
//    function InvokeNotify(msg : TMessage; kind : Cardinal) : TStatus_t;
    function SetTimeout(aTimeout : TBigtime_t) : TStatus_t;
    function Timeout : TBigtime_t;
//    function InvokeKind(notify : boolean) : Cardinal;
//    procedure BeginInvokeNotify(kind : Cardinal);
//    procedure EndInvokeNotify;
//    procedure _ReservedInvoker1;
//    procedure _ReservedInvoker2;
//    procedure _ReservedInvoker3;
    constructor Create(aInvoker : TInvoker);
//    function operator=( : TInvoker) : TInvoker;
//    procedure BMessage *fMessage;
//    procedure BMessenger fMessenger;
//    procedure BHandler *fReplyTo;
//    procedure uint32 fTimeout;
//    procedure uint32 fNotifyKind;
//    procedure uint32 _reserved[2];
  end;

function BInvoker_Create(AObject : TBeObject) : TCplusObject; cdecl; external BePascalLibName name 'BInvoker_Create';
function BInvoker_Create(AObject : TBeObject; message : TCplusObject; handler : TCplusObject; looper : TCPlusObject) : TCplusObject; cdecl; external BePascalLibName name 'BInvoker_Create';
function BInvoker_Create(AObject : TBeObject; message : TCplusObject; target : TCplusObject) : TCplusObject; cdecl; external BePascalLibName name 'BInvoker_Create';
procedure BInvoker_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_Free';
function BInvoker_SetMessage(AObject : TCPlusObject; message : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_SetMessage';
function BInvoker_Message(AObject : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BInvoker_Message';
function BInvoker_Command(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BInvoker_Command';
function BInvoker_SetTarget(AObject : TCPlusObject; h : TCPlusObject; loop : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_SetTarget';
function BInvoker_SetTarget(AObject : TCPlusObject; messenger : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_SetTarget_1';
function BInvoker_IsTargetLocal(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BInvoker_IsTargetLocal';
function BInvoker_Target(AObject : TCPlusObject; looper : TCplusObject) : THandler; cdecl; external BePascalLibName name 'BInvoker_Target';
function BInvoker_Messenger(AObject : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BInvoker_Messenger';
function BInvoker_SetHandlerForReply(AObject : TCPlusObject; handler : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_SetHandlerForReply';
function BInvoker_HandlerForReply(AObject : TCPlusObject) : THandler; cdecl; external BePascalLibName name 'BInvoker_HandlerForReply';
function BInvoker_Invoke(AObject : TCPlusObject; msg : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_Invoke';
//function BInvoker_InvokeNotify(AObject : TCPlusObject; msg : TCplusObject; kind : Cardinal) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_InvokeNotify';
function BInvoker_SetTimeout(AObject : TCPlusObject; timeout : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BInvoker_SetTimeout';
function BInvoker_Timeout(AObject : TCPlusObject) : TBigtime_t; cdecl; external BePascalLibName name 'BInvoker_Timeout';
//function BInvoker_InvokeKind(AObject : TCPlusObject; notify : boolean) : Cardinal; cdecl; external BePascalLibName name 'BInvoker_InvokeKind';
//procedure BInvoker_BeginInvokeNotify(AObject : TCPlusObject; kind : Cardinal); cdecl; external BePascalLibName name 'BInvoker_BeginInvokeNotify';
//procedure BInvoker_EndInvokeNotify(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_EndInvokeNotify';
//procedure BInvoker__ReservedInvoker1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker__ReservedInvoker1';
//procedure BInvoker__ReservedInvoker2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker__ReservedInvoker2';
//procedure BInvoker__ReservedInvoker3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker__ReservedInvoker3';
function BInvoker_Create(AObject : TBeObject; aInvoker : TCPlusObject) : TCplusObject; cdecl; external BePascalLibName name 'BInvoker_Create';
//function BInvoker_operator=(AObject : TCPlusObject;  : TInvoker) : TInvoker; cdecl; external BePascalLibName name 'BInvoker_operator=';
//procedure BInvoker_BMessage *fMessage(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_BMessage *fMessage';
//procedure BInvoker_BMessenger fMessenger(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_BMessenger fMessenger';
//procedure BInvoker_BHandler *fReplyTo(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_BHandler *fReplyTo';
//procedure BInvoker_uint32 fTimeout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_uint32 fTimeout';
//procedure BInvoker_uint32 fNotifyKind(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_uint32 fNotifyKind';
//procedure BInvoker_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BInvoker_uint32 _reserved[2]';

implementation

constructor TInvoker.Create;
begin
  BInvoker_Create(Self);
end;

constructor TInvoker.Create(aMessage : TMessage; handler : THandler; looper : TLooper);
begin
  CPlusObject := BInvoker_Create(Self, aMessage.CPlusObject, handler, looper);
end;

constructor TInvoker.Create(aMessage : TMessage; aTarget : TMessenger);
begin
  CPlusObject := BInvoker_Create(Self, aMessage.CPlusObject, aTarget.CPlusObject);
end;

destructor TInvoker.Destroy;
begin
  BInvoker_Free(CPlusObject);
end;

function TInvoker.SetMessage(aMessage : TMessage) : TStatus_t;
begin
  Result := BInvoker_SetMessage(CPlusObject, aMessage.CPlusObject);
end;

function TInvoker.Message : TMessage;
begin
  Result := TMessage.Wrap(BInvoker_Message(CPlusObject));
end;

function TInvoker.Command : Cardinal;
begin
  Result := BInvoker_Command(CPlusObject);
end;

function TInvoker.SetTarget(h : THandler; loop : TLooper) : TStatus_t;
begin
  WriteLn('Start of SetTarget');
  if loop <> nil then
  begin
    WriteLn('Différent de nil');
    Result := BInvoker_SetTarget(CPlusObject, h.CPlusObject, loop.CPlusObject);
  end
  else if h <> nil then
  begin
    WriteLn('Egale de nil');  
//    Result := BInvoker_SetTarget(CPlusObject, h.CPlusObject, nil);   
  end
  else
  begin  
    WriteLn('nil et nil');
    Result := BInvoker_SetTarget(CPlusObject, nil, nil);
  end;
  WriteLn('End of SetTarget');
end;

function TInvoker.SetTarget(aMessenger : TMessenger) : TStatus_t;
begin
  Result := BInvoker_SetTarget(CPlusObject, aMessenger.CPlusObject);
end;

function TInvoker.IsTargetLocal : boolean;
begin
  Result := BInvoker_IsTargetLocal(CPlusObject);
end;

function TInvoker.Target(looper : TLooper) : THandler;
begin
  Result := BInvoker_Target(CPlusObject, looper.CPlusObject);
end;

function TInvoker.Messenger : TMessenger;
begin
  Result := TMessenger.Wrap(BInvoker_Messenger(CPlusObject));
end;

function TInvoker.SetHandlerForReply(handler : THandler) : TStatus_t;
begin
  Result := BInvoker_SetHandlerForReply(CPlusObject, handler.CPlusObject);
end;

function TInvoker.HandlerForReply : THandler;
begin
  Result := BInvoker_HandlerForReply(CPlusObject);
end;

function TInvoker.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BInvoker_Invoke(CPlusObject, msg.CPlusObject);
end;

//function TInvoker.InvokeNotify(msg : TMessage; kind : Cardinal) : TStatus_t;
//begin
//  BInvoker_InvokeNotify(CPlusObject, msg.CPlusObject, kind);
//end;

function TInvoker.SetTimeout(aTimeout : TBigtime_t) : TStatus_t;
begin
  Result := BInvoker_SetTimeout(CPlusObject, timeout);
end;

function TInvoker.Timeout : TBigtime_t;
begin
  Result := BInvoker_Timeout(CPlusObject);
end;

//function TInvoker.InvokeKind(notify : boolean) : Cardinal;
//begin
//  BInvoker_InvokeKind(CPlusObject, notify);
//end;
//
//procedure TInvoker.BeginInvokeNotify(kind : Cardinal);
//begin
//  BInvoker_BeginInvokeNotify(CPlusObject, kind);
//end;
//
//procedure TInvoker.EndInvokeNotify;
//begin
//  BInvoker_EndInvokeNotify(CPlusObject);
//end;

//procedure TInvoker._ReservedInvoker1;
//begin
//  BInvoker__ReservedInvoker1(CPlusObject);
//end;
//
//procedure TInvoker._ReservedInvoker2;
//begin
//  BInvoker__ReservedInvoker2(CPlusObject);
//end;
//
//procedure TInvoker._ReservedInvoker3;
//begin
//  BInvoker__ReservedInvoker3(CPlusObject);
//end;

constructor TInvoker.Create(ainvoker : TInvoker);
begin
  BInvoker_Create(Self, aInvoker);
end;

//function TInvoker.operator=( : TInvoker) : TInvoker;
//begin
//  BInvoker_operator=(CPlusObject, );
//end;

//procedure TInvoker.BMessage *fMessage;
//begin
//  BInvoker_BMessage *fMessage(CPlusObject);
//end;
//
//procedure TInvoker.BMessenger fMessenger;
//begin
//  BInvoker_BMessenger fMessenger(CPlusObject);
//end;
//
//procedure TInvoker.BHandler *fReplyTo;
//begin
//  BInvoker_BHandler *fReplyTo(CPlusObject);
//end;
//
//procedure TInvoker.uint32 fTimeout;
//begin
//  BInvoker_uint32 fTimeout(CPlusObject);
//end;
//
//procedure TInvoker.uint32 fNotifyKind;
//begin
//  BInvoker_uint32 fNotifyKind(CPlusObject);
//end;
//
//procedure TInvoker.uint32 _reserved[2];
//begin
//  BInvoker_uint32 _reserved[2](CPlusObject);
//end;


end.
