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
unit button;

interface

uses
  beobj, Control, Message, Archivable, SupportDefs, Rect, Handler;

type
  TButton = class(TControl)
  private
  public
    destructor Destroy; override;
	constructor Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal); virtual;
    constructor Create(data : TMessage); override; 
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure Draw(updateRect : TRect); override;
    procedure MouseDown(where : TPoint); override;
    procedure AttachedToWindow; override;
    procedure KeyDown(bytes : PChar; numBytes : integer); override;
    // Hook functions
    procedure MakeDefault(state : boolean); virtual;
    procedure SetLabel(text : PChar);
    function IsDefault : boolean;
    procedure MessageReceived(msg : TMessage); override;
    procedure WindowActivated(state : boolean); override;
    procedure MouseUp(pt : TPoint); override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage); override;
    procedure DetachedFromWindow; override;
    procedure SetValue(aValue : integer);
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred; override;
    function Invoke(msg : TMessage) : TStatus_t;
    procedure FrameMoved(new_position : TPoint); override;
    procedure FrameResized(new_width : double; new_height : double); override;
    procedure MakeFocus(state : boolean); override;
    procedure AllAttached; override;
    procedure AllDetached; override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
//    procedure _ReservedButton1;
//    procedure _ReservedButton2;
//    procedure _ReservedButton3;
//    function operator=( : TButton) : TButton;
//    function DrawDefault(bounds : TRect; enabled : boolean) : TRect;
//    function Execute : TStatus_t;
//    procedure float fCachedWidth;
//    procedure bool fDrawAsDefault;
//    procedure uint32 _reserved[3];
//    procedure MakeDefault(flag : boolean); virtual;    
  end;

procedure BButton_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_Free';
function BButton_Create(AObject : TBeObject; frame : TCPlusObject; name, aLabel : PChar; message : TCPlusObject; resizingMode, flags : Cardinal) : TCPlusObject; cdecl; external BePascalLibName name 'BButton_Create';
function BButton_Create(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BButton_Create';
function BButton_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BButton_Instantiate';
function BButton_Archive(AObject : TCPlusObject; data : TCplusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BButton_Archive';
procedure BButton_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BButton_Draw';
procedure BButton_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BButton_MouseDown';
procedure BButton_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_AttachedToWindow';
procedure BButton_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BButton_KeyDown';
procedure BButton_MakeDefault(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BButton_MakeDefault';
procedure BButton_SetLabel(AObject : TCPlusObject; text : PChar); cdecl; external BePascalLibName name 'BButton_SetLabel';
function BButton_IsDefault(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BButton_IsDefault';
procedure BButton_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BButton_MessageReceived';
procedure BButton_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BButton_WindowActivated';
procedure BButton_MouseUp(AObject : TCPlusObject; pt : TCplusObject); cdecl; external BePascalLibName name 'BButton_MouseUp';
procedure BButton_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TMessage); cdecl; external BePascalLibName name 'BButton_MouseMoved';
procedure BButton_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_DetachedFromWindow';
procedure BButton_SetValue(AObject : TCPlusObject; aValue : integer); cdecl; external BePascalLibName name 'BButton_SetValue';
procedure BButton_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BButton_GetPreferredSize';
procedure BButton_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_ResizeToPreferred';
function BButton_Invoke(AObject : TCPlusObject; msg : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BButton_Invoke';
procedure BButton_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BButton_FrameMoved';
procedure BButton_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BButton_FrameResized';
procedure BButton_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BButton_MakeFocus';
procedure BButton_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_AllAttached';
procedure BButton_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_AllDetached';
function BButton_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BButton_ResolveSpecifier';
function BButton_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BButton_GetSupportedSuites';
function BButton_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BButton_Perform';
//procedure BButton__ReservedButton1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton__ReservedButton1';
//procedure BButton__ReservedButton2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton__ReservedButton2';
//procedure BButton__ReservedButton3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton__ReservedButton3';
//function BButton_operator=(AObject : TCPlusObject;  : TButton) : TButton; cdecl; external BePascalLibName name 'BButton_operator=';
//function BButton_DrawDefault(AObject : TCPlusObject; bounds : TCPlusObject; enabled : boolean) : TRect; cdecl; external BePascalLibName name 'BButton_DrawDefault';
//function BButton_Execute(AObject : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BButton_Execute';
//procedure BButton_float fCachedWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_float fCachedWidth';
//procedure BButton_bool fDrawAsDefault(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_bool fDrawAsDefault';
//procedure BButton_uint32 _reserved[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BButton_uint32 _reserved[3]';

//var
//  procedure BButton_MakeDefault_hook(Button : TButton; flag : boolean); cdecl; external BePascalLibName name 'BButton_MakeDefault';

implementation

var
  Button_MakeDefault_hook : Pointer; cvar; external;

destructor TButton.Destroy;
begin
  BButton_Free(CPlusObject);
  inherited;
end;

constructor TButton.Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal);
begin
  CreatePas;
  WriteLn('Creation bouton');
  CPlusObject := BButton_Create(Self, frame.CPlusObject, name, aLabel, message.CPlusObject, resizingMode, flags);
end;

constructor TButton.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BButton_Create(Self, data.CPlusObject);
end;

function TButton.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BButton_Instantiate(CPlusObject, data.CPlusObject);
end;

function TButton.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BButton_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TButton.Draw(updateRect : TRect);
begin

end;

procedure TButton.MouseDown(where : TPoint);
begin

end;

procedure TButton.AttachedToWindow;
begin

end;

procedure TButton.KeyDown(bytes : PChar; numBytes : integer);
begin

end;

procedure TButton.MakeDefault(state : boolean);
begin

end;

procedure TButton.SetLabel(text : PChar);
begin
  BButton_SetLabel(CPlusObject, text);
end;

function TButton.IsDefault : boolean;
begin
  Result := BButton_IsDefault(CPlusObject);
end;

procedure TButton.MessageReceived(msg : TMessage);
begin
  WriteLn('Bonjour, ici le bouton !');
//  BButton_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TButton.WindowActivated(state : boolean);
begin
//  BButton_WindowActivated(CPlusObject, state);
end;

procedure TButton.MouseUp(pt : TPoint);
begin
//  BButton_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TButton.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
//  BButton_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TButton.DetachedFromWindow;
begin
//  BButton_DetachedFromWindow(CPlusObject);
end;

procedure TButton.SetValue(aValue : integer);
begin
//  BButton_SetValue(CPlusObject, aValue);
end;

procedure TButton.GetPreferredSize(width : double; height : double);
begin
//  BButton_GetPreferredSize(CPlusObject, width, height);
end;

procedure TButton.ResizeToPreferred;
begin
//  BButton_ResizeToPreferred(CPlusObject);
end;

function TButton.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BButton_Invoke(CPlusObject, msg.CPlusObject);
end;

procedure TButton.FrameMoved(new_position : TPoint);
begin
//  BButton_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TButton.FrameResized(new_width : double; new_height : double);
begin
//  BButton_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TButton.MakeFocus(state : boolean);
begin
  BButton_MakeFocus(CPlusObject, state);
end;

procedure TButton.AllAttached;
begin
//  BButton_AllAttached(CPlusObject);
end;

procedure TButton.AllDetached;
begin
//  BButton_AllDetached(CPlusObject);
end;

function TButton.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BButton_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TButton.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BButton_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function TButton.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BButton_Perform(CPlusObject, d, arg);
end;

{procedure TButton._ReservedButton1;
begin
  BButton__ReservedButton1(CPlusObject);
end;

procedure TButton._ReservedButton2;
begin
  BButton__ReservedButton2(CPlusObject);
end;

procedure TButton._ReservedButton3;
begin
  BButton__ReservedButton3(CPlusObject);
end;}

{function TButton.operator=( : TButton) : TButton;
begin
  Result := BButton_operator=(CPlusObject, );
end;
}

{function TButton.DrawDefault(bounds : TRect; enabled : boolean) : TRect;
begin
  Result := BButton_DrawDefault(CPlusObject, bounds.CPlusObject, enabled);
end;

function TButton.Execute : TStatus_t;
begin
  Result := BButton_Execute(CPlusObject);
end;}

{procedure TButton.float fCachedWidth;
begin
  BButton_float fCachedWidth(CPlusObject);
end;
}

{procedure TButton.bool fDrawAsDefault;
begin
  BButton_bool fDrawAsDefault(CPlusObject);
end;
}

{procedure TButton.uint32 _reserved[3];
begin
  BButton_uint32 _reserved[3](CPlusObject);
end;
}

{procedure TButton.MakeDefault(flag : boolean);
begin
end;
}

procedure Button_MakeDefault_hook_func(Button : TButton; flag : boolean); cdecl;
begin
  if Button <> nil then
    Button.MakeDefault(flag);
end;

initialization
  Button_MakeDefault_hook := @Button_MakeDefault_hook_func;

end.
