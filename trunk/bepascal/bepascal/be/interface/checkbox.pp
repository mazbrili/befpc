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
unit checkbox;

interface

uses
  beobj, Control, Message, Archivable, SupportDefs, Rect, Handler;

type TCheckBox  = class(TControl)
  private
  public
    destructor Destroy;override;
	constructor Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal); virtual;
    constructor Create(data : TMessage) ;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure Draw(updateRect : TRect);override;
    procedure AttachedToWindow;override;
    procedure MouseDown(where : TPoint);override;
    procedure MessageReceived(msg : TMessage);override;
    procedure WindowActivated(state : boolean);override;
    procedure KeyDown(bytes : PChar; numBytes : integer);override;
    procedure MouseUp(pt : TPoint);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure DetachedFromWindow;override;
    procedure SetValue(avalue : integer);
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred;override;
    function Invoke(msg : TMessage) : TStatus_t;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure MakeFocus(state : boolean);override;
    procedure AllAttached;override;
    procedure AllDetached;override;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
   // procedure _ReservedCheckBox1;
    //procedure _ReservedCheckBox2;
    //procedure _ReservedCheckBox3;
    //function operator=( : ) : ;
   // procedure bool fOutlined;
    //procedure uint32 _reserved[2];
  end;

procedure BCheckBox_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_FREE';
function BCheckBox_Create(AObject : TBeObject; frame : TCPlusObject; name, aLabel : PChar; message : TCPlusObject; resizingMode, flags : Cardinal) : TCPlusObject; cdecl; external BePascalLibName name 'BCheckBox_Create';
function BCheckBox_Create_1(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BCheckBox_Create_1';
function BCheckBox_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BCheckBox_Instantiate';
function BCheckBox_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BCheckBox_Archive';
procedure BCheckBox_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_Draw';
procedure BCheckBox_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_AttachedToWindow';
procedure BCheckBox_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_MouseDown';
procedure BCheckBox_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_MessageReceived';
procedure BCheckBox_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BCheckBox_WindowActivated';
procedure BCheckBox_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BCheckBox_KeyDown';
procedure BCheckBox_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_MouseUp';
procedure BCheckBox_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TMessage); cdecl; external BePascalLibName name 'BCheckBox_MouseMoved';
procedure BCheckBox_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_DetachedFromWindow';
procedure BCheckBox_SetValue(AObject : TCPlusObject; value : integer); cdecl; external BePascalLibName name 'BCheckBox_SetValue';
procedure BCheckBox_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BCheckBox_GetPreferredSize';
procedure BCheckBox_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_ResizeToPreferred';
function BCheckBox_Invoke(AObject : TCPlusObject; msg : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BCheckBox_Invoke';
procedure BCheckBox_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_FrameMoved';
procedure BCheckBox_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BCheckBox_FrameResized';
function BCheckBox_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BCheckBox_ResolveSpecifier';
function BCheckBox_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BCheckBox_GetSupportedSuites';
procedure BCheckBox_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BCheckBox_MakeFocus';
procedure BCheckBox_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_AllAttached';
procedure BCheckBox_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_AllDetached';
function BCheckBox_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BCheckBox_Perform';
//procedure BCheckBox__ReservedCheckBox1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox__ReservedCheckBox1';
//procedure BCheckBox__ReservedCheckBox2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox__ReservedCheckBox2';
//procedure BCheckBox__ReservedCheckBox3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox__ReservedCheckBox3';
//function BCheckBox_operator=(AObject : TCPlusObject;  : ) : ; cdecl; external BePascalLibName name 'BCheckBox_operator=';
//procedure BCheckBox_bool fOutlined(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_bool fOutlined';
//procedure BCheckBox_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BCheckBox_uint32 _reserved[2]';

implementation

destructor TCheckBox.Destroy;
begin
  BCheckBox_Free(CPlusObject);
  inherited;
end;

constructor TCheckBox.Create(frame : TRect; name, aLabel : PChar; message : TMessage; resizingMode, flags : Cardinal);
begin
  CreatePas;
  CPlusObject := BCheckBox_Create(Self, frame.CPlusObject, name, aLabel, message.CPlusObject, resizingMode, flags);
end;

constructor TCheckBox.Create(data : TMessage) ;
begin
  CreatePas;
  CPlusObject := BCheckBox_Create_1(Self, data.CPlusObject);
end;

function TCheckBox.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BCheckBox_Instantiate(CPlusObject, data.CPlusObject);
end;

function TCheckBox.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BCheckBox_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TCheckBox.Draw(updateRect : TRect);
begin
  //BCheckBox_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure TCheckBox.AttachedToWindow;
begin
  //BCheckBox_AttachedToWindow(CPlusObject);
end;

procedure TCheckBox.MouseDown(where : TPoint);
begin
  //BCheckBox_MouseDown(CPlusObject, where.CPlusObject);
end;

procedure TCheckBox.MessageReceived(msg : TMessage);
begin
  //BCheckBox_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TCheckBox.WindowActivated(state : boolean);
begin
 // BCheckBox_WindowActivated(CPlusObject, state);
end;

procedure TCheckBox.KeyDown(bytes : PChar; numBytes : integer);
begin
  //BCheckBox_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure TCheckBox.MouseUp(pt : TPoint);
begin
  //BCheckBox_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TCheckBox.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  //BCheckBox_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TCheckBox.DetachedFromWindow;
begin
  //BCheckBox_DetachedFromWindow(CPlusObject);
end;

procedure TCheckBox.SetValue(avalue : integer);
begin
  BCheckBox_SetValue(CPlusObject, avalue);
end;

procedure TCheckBox.GetPreferredSize(width : double; height : double);
begin
  BCheckBox_GetPreferredSize(CPlusObject, width, height);
end;

procedure TCheckBox.ResizeToPreferred;
begin
  BCheckBox_ResizeToPreferred(CPlusObject);
end;

function TCheckBox.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BCheckBox_Invoke(CPlusObject, msg.CPlusObject);
end;

procedure TCheckBox.FrameMoved(new_position : TPoint);
begin
  BCheckBox_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TCheckBox.FrameResized(new_width : double; new_height : double);
begin
  BCheckBox_FrameResized(CPlusObject, new_width, new_height);
end;

function TCheckBox.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BCheckBox_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TCheckBox.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BCheckBox_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TCheckBox.MakeFocus(state : boolean);
begin
  BCheckBox_MakeFocus(CPlusObject, state);
end;

procedure TCheckBox.AllAttached;
begin
  BCheckBox_AllAttached(CPlusObject);
end;

procedure TCheckBox.AllDetached;
begin
  BCheckBox_AllDetached(CPlusObject);
end;

function TCheckBox.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BCheckBox_Perform(CPlusObject, d, arg);
end;

{procedure ._ReservedCheckBox1;
begin
  BCheckBox__ReservedCheckBox1(CPlusObject);
end;

procedure ._ReservedCheckBox2;
begin
  BCheckBox__ReservedCheckBox2(CPlusObject);
end;

procedure ._ReservedCheckBox3;
begin
  BCheckBox__ReservedCheckBox3(CPlusObject);
end;

function .operator=( : ) : ;
begin
  Result := BCheckBox_operator=(CPlusObject, );
end;

procedure .bool fOutlined;
begin
  BCheckBox_bool fOutlined(CPlusObject);
end;

procedure .uint32 _reserved[2];
begin
  BCheckBox_uint32 _reserved[2](CPlusObject);
end;

}
end.
