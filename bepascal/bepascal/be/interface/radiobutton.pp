{   BePascal - A pascal wrapper around the BeOS API                             
    Copyright (C) 2003 Olivier Coursiere                                        
                       Eric Jourde                                              
                       Oscar Lesta

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
unit radiobutton;

interface

uses
  beobj,  Control, Message, Archivable, SupportDefs, Rect, Handler;

type
   TRadioButton = class(TControl)
  private
  public
	constructor Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal); virtual;
    constructor Create(data : TMessage); override;
    destructor Destroy; override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure Draw(updateRect : TRect); override;
    procedure MouseDown(where : TPoint); override;
    procedure AttachedToWindow; override;
    procedure KeyDown(bytes : PChar; numBytes : integer); override;
    procedure SetValue(aValue : integer);
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred; override;
    function Invoke(msg : TMessage) : TStatus_t;
    procedure MessageReceived(msg : TMessage); override;
    procedure WindowActivated(state : boolean); override;
    procedure MouseUp(pt : TPoint); override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage); override;
    procedure DetachedFromWindow; override;
    procedure FrameMoved(new_position : TPoint); override;
    procedure FrameResized(new_width : double; new_height : double); override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    procedure MakeFocus(state : boolean); override;
    procedure AllAttached; override;
    procedure AllDetached; override;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
//    procedure _ReservedRadioButton1;
//    procedure _ReservedRadioButton2;
//    function operator=( :  TRadioButton) :  TRadioButton;
//    procedure BBitmap *sBitmaps[2][3];
//    procedure bool fOutlined;
//    procedure uint32 _reserved[2];
  end;

function BRadioButton_Create(AObject : TBeObject; frame : TCPlusObject;
													name, aLabel : PChar; message : TCPlusObject;
													resizingMode, flags : Cardinal) : TCPlusObject;
													cdecl; external BePascalLibName name 'BRadioButton_Create';
function BRadioButton_Create_1(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BRadioButton_Create_1';

procedure BRadioButton_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_FREE';

function BRadioButton_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BRadioButton_Instantiate';
function BRadioButton_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BRadioButton_Archive';
procedure BRadioButton_Draw(AObject : TCPlusObject; updateRect : TRect); cdecl; external BePascalLibName name 'BRadioButton_Draw';
procedure BRadioButton_MouseDown(AObject : TCPlusObject; where : TPoint); cdecl; external BePascalLibName name 'BRadioButton_MouseDown';
procedure BRadioButton_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_AttachedToWindow';
procedure BRadioButton_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BRadioButton_KeyDown';
procedure BRadioButton_SetValue(AObject : TCPlusObject; value : integer); cdecl; external BePascalLibName name 'BRadioButton_SetValue';
procedure BRadioButton_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BRadioButton_GetPreferredSize';
procedure BRadioButton_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_ResizeToPreferred';
function BRadioButton_Invoke(AObject : TCPlusObject; msg : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BRadioButton_Invoke';
procedure BRadioButton_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_MessageReceived';
procedure BRadioButton_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BRadioButton_WindowActivated';
procedure BRadioButton_MouseUp(AObject : TCPlusObject; pt : TPoint); cdecl; external BePascalLibName name 'BRadioButton_MouseUp';
procedure BRadioButton_MouseMoved(AObject : TCPlusObject; pt : TPoint; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_MouseMoved';
procedure BRadioButton_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_DetachedFromWindow';
procedure BRadioButton_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_FrameMoved';
procedure BRadioButton_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BRadioButton_FrameResized';
function BRadioButton_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BRadioButton_ResolveSpecifier';
procedure BRadioButton_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BRadioButton_MakeFocus';
procedure BRadioButton_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_AllAttached';
procedure BRadioButton_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_AllDetached';
function BRadioButton_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BRadioButton_GetSupportedSuites';
function BRadioButton_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BRadioButton_Perform';
//procedure BRadioButton__ReservedRadioButton1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton__ReservedRadioButton1';
//procedure BRadioButton__ReservedRadioButton2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton__ReservedRadioButton2';
//function BRadioButton_operator=(AObject : TCPlusObject;  :  TRadioButton) :  TRadioButton; cdecl; external BePascalLibName name 'BRadioButton_operator=';
//procedure BRadioButton_BBitmap *sBitmaps[2][3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_BBitmap *sBitmaps[2][3]';
//procedure BRadioButton_bool fOutlined(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_bool fOutlined';
//procedure BRadioButton_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRadioButton_uint32 _reserved[2]';

implementation

constructor TRadioButton.Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal);
begin
  CreatePas;
  CPlusObject := BRadioButton_Create(Self, frame.CPlusObject, name, aLabel, message.CPlusObject, resizingMode, flags);
end;

constructor  TRadioButton.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BRadioButton_Create_1(Self, data.CPlusObject);
end;

destructor  TRadioButton.Destroy;
begin
  BRadioButton_Free(CPlusObject);
  inherited;
end;

function  TRadioButton.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BRadioButton_Instantiate(CPlusObject, data.CPlusObject);
end;

function  TRadioButton.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BRadioButton_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure  TRadioButton.Draw(updateRect : TRect);
begin
//  BRadioButton_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure  TRadioButton.MouseDown(where : TPoint);
begin
//  BRadioButton_MouseDown(CPlusObject, where.CPlusObject);
end;

procedure  TRadioButton.AttachedToWindow;
begin
//  BRadioButton_AttachedToWindow(CPlusObject);
end;

procedure  TRadioButton.KeyDown(bytes : PChar; numBytes : integer);
begin
//  BRadioButton_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure  TRadioButton.SetValue(aValue : integer);
begin
  BRadioButton_SetValue(CPlusObject, aValue);
end;

procedure  TRadioButton.GetPreferredSize(width : double; height : double);
begin
  BRadioButton_GetPreferredSize(CPlusObject, width, height);
end;

procedure  TRadioButton.ResizeToPreferred;
begin
  BRadioButton_ResizeToPreferred(CPlusObject);
end;

function  TRadioButton.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BRadioButton_Invoke(CPlusObject, msg.CPlusObject);
end;

procedure  TRadioButton.MessageReceived(msg : TMessage);
begin
//  BRadioButton_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure  TRadioButton.WindowActivated(state : boolean);
begin
//  BRadioButton_WindowActivated(CPlusObject, state);
end;

procedure  TRadioButton.MouseUp(pt : TPoint);
begin
//  BRadioButton_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure  TRadioButton.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
//  BRadioButton_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure  TRadioButton.DetachedFromWindow;
begin
//  BRadioButton_DetachedFromWindow(CPlusObject);
end;

procedure  TRadioButton.FrameMoved(new_position : TPoint);
begin
//  BRadioButton_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure  TRadioButton.FrameResized(new_width : double; new_height : double);
begin
//  BRadioButton_FrameResized(CPlusObject, new_width, new_height);
end;

function  TRadioButton.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BRadioButton_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure  TRadioButton.MakeFocus(state : boolean);
begin
  BRadioButton_MakeFocus(CPlusObject, state);
end;

procedure  TRadioButton.AllAttached;
begin
//  BRadioButton_AllAttached(CPlusObject);
end;

procedure  TRadioButton.AllDetached;
begin
//  BRadioButton_AllDetached(CPlusObject);
end;

function  TRadioButton.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BRadioButton_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function  TRadioButton.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BRadioButton_Perform(CPlusObject, d, arg);
end;

{
procedure  TRadioButton._ReservedRadioButton1;
begin
  BRadioButton__ReservedRadioButton1(CPlusObject);
end;

procedure  TRadioButton._ReservedRadioButton2;
begin
  BRadioButton__ReservedRadioButton2(CPlusObject);
end;

function  TRadioButton.operator=( :  TRadioButton) :  TRadioButton;
begin
  Result := BRadioButton_operator=(CPlusObject, );
end;

procedure  TRadioButton.BBitmap *sBitmaps[2][3];
begin
  BRadioButton_BBitmap *sBitmaps[2][3](CPlusObject);
end;

procedure  TRadioButton.bool fOutlined;
begin
  BRadioButton_bool fOutlined(CPlusObject);
end;

procedure  TRadioButton.uint32 _reserved[2];
begin
  BRadioButton_uint32 _reserved[2](CPlusObject);
end;
}

end.
