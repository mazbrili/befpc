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
unit control;

interface

uses
  beobj, View, Message, Archivable, Rect, Handler, SupportDefs, Invoker;

type
  TControl = class(TView)
  private
  protected
    FInvoker : TInvoker;
    function GetInvoker : TInvoker;
  public
    constructor Create(frame : TCPlusObject; name, aLabel : PChar; message : TCPlusObject; resizingMode, flags : Cardinal); virtual;
    destructor Destroy; override;
    constructor Create(data : TMessage); virtual;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure WindowActivated(state : boolean); override;
    procedure AttachedToWindow; override;
    procedure MessageReceived(msg : TMessage); override;
    procedure MakeFocus(state : boolean); virtual;
    procedure KeyDown(bytes : PChar; numBytes : integer); override;
    procedure MouseDown(pt : TPoint); override;
    procedure MouseUp(pt : TPoint); override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage); override;
    procedure DetachedFromWindow; override;
    procedure SetLabel(text : PChar);
    function Labl : PChar;
    procedure SetValue(aValue : integer);
    function Value : integer;
    procedure SetEnabled(aOn : boolean);
    function IsEnabled : boolean;
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred; override;
    function Invoke(msg : TMessage) : TStatus_t;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti{;-)} : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure AllAttached; override;
    procedure AllDetached; override;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
//    function IsFocusChanging : boolean;
//    function IsTracking : boolean;
//    procedure SetTracking(state : boolean);
//    procedure SetValueNoUpdate(aValue : integer);
//    procedure _ReservedControl1;
//    procedure _ReservedControl2;
//    procedure _ReservedControl3;
//    procedure _ReservedControl4;
//    function operator=( : TControl) : TControl;
//    procedure InitData(data : TMessage);
//    procedure char *fLabel;
//    procedure int32 fValue;
//    procedure bool fEnabled;
//    procedure bool fFocusChanging;
//    procedure bool fTracking;
//    procedure bool fWantsNav;
//    procedure uint32 _reserved[4];
    property Invoker : TInvoker read GetInvoker;
  end;

//function BControl_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BControl_Create';
function BControl_Create(AObject : TBeObject; frame : TCPlusObject; name, aLabel : PChar; message : TCPlusObject; resizingMode, flags : Cardinal) : TCPlusObject; cdecl; external BePascalLibName name 'BControl_Create';
procedure BControl_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_Free';
function BControl_Create(AObject : TBeObject; data : TCplusObject) : TCplusObject; cdecl; external BePascalLibName name 'BControl_Create';
function BControl_Instantiate(AObject : TCPlusObject; data : TCplusObject) : TArchivable; cdecl; external BePascalLibName name 'BControl_Instantiate';
function BControl_Archive(AObject : TCPlusObject; data : TCplusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BControl_Archive';
procedure BControl_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BControl_WindowActivated';
procedure BControl_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_AttachedToWindow';
procedure BControl_MessageReceived(AObject : TCPlusObject; msg : TCplusObject); cdecl; external BePascalLibName name 'BControl_MessageReceived';
procedure BControl_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BControl_MakeFocus';
procedure BControl_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BControl_KeyDown';
procedure BControl_MouseDown(AObject : TCPlusObject; pt : TCplusObject); cdecl; external BePascalLibName name 'BControl_MouseDown';
procedure BControl_MouseUp(AObject : TCPlusObject; pt : TCplusObject); cdecl; external BePascalLibName name 'BControl_MouseUp';
procedure BControl_MouseMoved(AObject : TCPlusObject; pt : TCplusObject; code : Cardinal; msg : TCplusObject); cdecl; external BePascalLibName name 'BControl_MouseMoved';
procedure BControl_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_DetachedFromWindow';
procedure BControl_SetLabel(AObject : TCPlusObject; text : PChar); cdecl; external BePascalLibName name 'BControl_SetLabel';
function BControl_Labl(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BControl_Label';
procedure BControl_SetValue(AObject : TCPlusObject; value : integer); cdecl; external BePascalLibName name 'BControl_SetValue';
function BControl_Value(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BControl_Value';
procedure BControl_SetEnabled(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BControl_SetEnabled';
function BControl_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BControl_IsEnabled';
procedure BControl_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BControl_GetPreferredSize';
procedure BControl_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_ResizeToPreferred';
function BControl_Invoke(AObject : TCPlusObject; msg : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BControl_Invoke';
function BControl_ResolveSpecifier(AObject : TCPlusObject; msg : TCplusObject; index : integer; specifier : TCplusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BControl_ResolveSpecifier';
function BControl_GetSupportedSuites(AObject : TCPlusObject; data : TCplusObject) : TStatus_t; cdecl; external BePascalLibName name 'BControl_GetSupportedSuites';
procedure BControl_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_AllAttached';
procedure BControl_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_AllDetached';
function BControl_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BControl_Perform';
//function BControl_IsFocusChanging(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BControl_IsFocusChanging';
//function BControl_IsTracking(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BControl_IsTracking';
//procedure BControl_SetTracking(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BControl_SetTracking';
//procedure BControl_SetValueNoUpdate(AObject : TCPlusObject; aValue : integer); cdecl; external BePascalLibName name 'BControl_SetValueNoUpdate';
//procedure BControl__ReservedControl1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl__ReservedControl1';
//procedure BControl__ReservedControl2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl__ReservedControl2';
//procedure BControl__ReservedControl3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl__ReservedControl3';
//procedure BControl__ReservedControl4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl__ReservedControl4';
//function BControl_operator=(AObject : TCPlusObject;  : TControl) : TControl; cdecl; external BePascalLibName name 'BControl_operator=';
procedure BControl_InitData(AObject : TCPlusObject; data : TCplusObject); cdecl; external BePascalLibName name 'BControl_InitData';
//procedure BControl_char *fLabel(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_char *fLabel';
//procedure BControl_int32 fValue(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_int32 fValue';
//procedure BControl_bool fEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_bool fEnabled';
//procedure BControl_bool fFocusChanging(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_bool fFocusChanging';
//procedure BControl_bool fTracking(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_bool fTracking';
//procedure BControl_bool fWantsNav(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_bool fWantsNav';
//procedure BControl_uint32 _reserved[4](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BControl_uint32 _reserved[4]';

implementation

constructor TControl.Create(frame : TCPlusObject; name, aLabel : PChar; message : TCPlusObject; resizingMode, flags : Cardinal);
begin
  CPlusObject := BControl_Create(Self, frame, name, aLabel, message, resizingMode, flags);
end;

destructor TControl.Destroy;
begin
  if FInvoker <> nil then
    FInvoker.UnWrap;
  BControl_Free(CPlusObject);
end;

constructor TControl.Create(data : TMessage);
begin
  CPlusObject := BControl_Create(Self, data.CPlusObject);
end;

function TControl.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BControl_Instantiate(CPlusObject, data.CPlusObject);
end;

function TControl.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BControl_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TControl.WindowActivated(state : boolean);
begin
//  BControl_WindowActivated(CPlusObject, state);
end;

procedure TControl.AttachedToWindow;
begin
//  BControl_AttachedToWindow(CPlusObject);
end;

procedure TControl.MessageReceived(msg : TMessage);
begin
//  BControl_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TControl.MakeFocus(state : boolean);
begin
//  BControl_MakeFocus(CPlusObject, state);
end;

procedure TControl.KeyDown(bytes : PChar; numBytes : integer);
begin
//  BControl_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure TControl.MouseDown(pt : TPoint);
begin
//  BControl_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure TControl.MouseUp(pt : TPoint);
begin
//  BControl_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TControl.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
//  BControl_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TControl.DetachedFromWindow;
begin
//  BControl_DetachedFromWindow(CPlusObject);
end;

procedure TControl.SetLabel(text : PChar);
begin
  BControl_SetLabel(CPlusObject, text);
end;

function TControl.Labl : PChar;
begin
  Result := BControl_Labl(CPlusObject);
end;

procedure TControl.SetValue(aValue : integer);
begin
  BControl_SetValue(CPlusObject, aValue);
end;

function TControl.Value : integer;
begin
  Result := BControl_Value(CPlusObject);
end;

procedure TControl.SetEnabled(aOn : boolean);
begin
  BControl_SetEnabled(CPlusObject, aOn);
end;

function TControl.IsEnabled : boolean;
begin
  Result := BControl_IsEnabled(CPlusObject);
end;

procedure TControl.GetPreferredSize(width : double; height : double);
begin
//  BControl_GetPreferredSize(CPlusObject, width, height);
end;

procedure TControl.ResizeToPreferred;
begin
//  BControl_ResizeToPreferred(CPlusObject);
end;

function TControl.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BControl_Invoke(CPlusObject, msg.CPlusObject);
end;

function TControl.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BControl_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TControl.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BControl_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TControl.AllAttached;
begin
//  BControl_AllAttached(CPlusObject);
end;

procedure TControl.AllDetached;
begin
//  BControl_AllDetached(CPlusObject);
end;

function TControl.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BControl_Perform(CPlusObject, d, arg);
end;

//function TControl.IsFocusChanging : boolean;
//begin
//  Result := BControl_IsFocusChanging(CPlusObject);
//end;
//
//function TControl.IsTracking : boolean;
//begin
//  Result := BControl_IsTracking(CPlusObject);
//end;
//
//procedure TControl.SetTracking(state : boolean);
//begin
//  BControl_SetTracking(CPlusObject, state);
//end;
//
//procedure TControl.SetValueNoUpdate(aValue : integer);
//begin
//  BControl_SetValueNoUpdate(CPlusObject, aValue);
//end;

//procedure TControl._ReservedControl1;
//begin
//  BControl__ReservedControl1(CPlusObject);
//end;
//
//procedure TControl._ReservedControl2;
//begin
//  BControl__ReservedControl2(CPlusObject);
//end;
//
//procedure TControl._ReservedControl3;
//begin
//  BControl__ReservedControl3(CPlusObject);
//end;
//
//procedure TControl._ReservedControl4;
//begin
//  BControl__ReservedControl4(CPlusObject);
//end;

//function TControl.operator=( : TControl) : TControl;
//begin
//  Result := BControl_operator=(CPlusObject, );
//end;

//procedure TControl.InitData(data : TMessage);
//begin
//  BControl_InitData(CPlusObject, data.CPlusObject);
//end;

//procedure TControl.char *fLabel;
//begin
//  BControl_char *fLabel(CPlusObject);
//end;
//
//procedure TControl.int32 fValue;
//begin
//  BControl_int32 fValue(CPlusObject);
//end;
//
//procedure TControl.bool fEnabled;
//begin
//  BControl_bool fEnabled(CPlusObject);
//end;
//
//procedure TControl.bool fFocusChanging;
//begin
//  BControl_bool fFocusChanging(CPlusObject);
//end;
//
//procedure TControl.bool fTracking;
//begin
//  BControl_bool fTracking(CPlusObject);
//end;
//
//procedure TControl.bool fWantsNav;
//begin
//  BControl_bool fWantsNav(CPlusObject);
//end;
//
//procedure TControl.uint32 _reserved[4];
//begin
//  BControl_uint32 _reserved[4](CPlusObject);
//end;

function TControl.GetInvoker : TInvoker;
begin
  if FInvoker = nil then
  begin
    WriteLn('Before GetInvoker');
    Result := TInvoker.Wrap(CPlusObject);
    WriteLn('After GetInvoker');    
  end;
  Result := FInvoker;
end;

end.
