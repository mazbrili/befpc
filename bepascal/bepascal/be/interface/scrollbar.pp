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
unit scrollbar;

interface

uses
  beobj,view,rect,interfacedefs,Message,Archivable,SupportDefs,Handler;

type
   TScrollBar = class(TView)
  private
  public
    constructor Create(frame : TRect; name : pchar; atarget : TView; min,max : real; direction : Torientation); 
    constructor Create_1(data : TMessage);
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure AttachedToWindow;override;
    procedure SetValue(avalue : double);
    function Value : double;
    procedure SetProportion( avalue: double);
    function Proportion : double;
    procedure ValueChanged(newValue : double);
    procedure SetRange(min : double; max : double);
    procedure GetRange(min : double; max : double);
    procedure SetSteps(smallStep : double; largeStep : double);
    procedure GetSteps(smallStep : double; largeStep : double);
    procedure SetTarget(atarget : TView);
    procedure SetTarget(targetName : PChar);
    function Target : TView;
    function Orientation : TOrientation;
    procedure MessageReceived(msg : TMessage);override;
    procedure MouseDown(pt : TPoint);override;
    procedure MouseUp(pt : TPoint);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure DetachedFromWindow;override;
    procedure Draw(updateRect : TRect);override;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    procedure ResizeToPreferred;override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    procedure AllAttached;override;
    procedure AllDetached;override;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
  end;

function BScrollBar_Create(AObject : TBeObject;frame : TCPlusObject; name : pchar; target : TCPlusObject; min,max : real; direction : Torientation): TCPlusObject; cdecl; external BePascalLibName name 'BScrollBar_Create';
function BScrollBar_Create_1(AObject : TBeObject; data : TCPlusObject):TCPlusObject; cdecl; external BePascalLibName name 'BScrollBar_Create_1';
procedure BScrollBar_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_Free';
function BScrollBar_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BScrollBar_Instantiate';
function BScrollBar_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BScrollBar_Archive';
procedure BScrollBar_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_AttachedToWindow';
procedure BScrollBar_SetValue(AObject : TCPlusObject; value : double); cdecl; external BePascalLibName name 'BScrollBar_SetValue';
function BScrollBar_Value(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BScrollBar_Value';
procedure BScrollBar_SetProportion(AObject : TCPlusObject;  avalue: double); cdecl; external BePascalLibName name 'BScrollBar_SetProportion';
function BScrollBar_Proportion(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BScrollBar_Proportion';
procedure BScrollBar_ValueChanged(AObject : TCPlusObject; newValue : double); cdecl; external BePascalLibName name 'BScrollBar_ValueChanged';
procedure BScrollBar_SetRange(AObject : TCPlusObject; min : double; max : double); cdecl; external BePascalLibName name 'BScrollBar_SetRange';
procedure BScrollBar_GetRange(AObject : TCPlusObject; min : double; max : double); cdecl; external BePascalLibName name 'BScrollBar_GetRange';
procedure BScrollBar_SetSteps(AObject : TCPlusObject; smallStep : double; largeStep : double); cdecl; external BePascalLibName name 'BScrollBar_SetSteps';
procedure BScrollBar_GetSteps(AObject : TCPlusObject; smallStep : double; largeStep : double); cdecl; external BePascalLibName name 'BScrollBar_GetSteps';
procedure BScrollBar_SetTarget(AObject : TCPlusObject; target : TView); cdecl; external BePascalLibName name 'BScrollBar_SetTarget';
procedure BScrollBar_SetTarget(AObject : TCPlusObject; targetName : PChar); cdecl; external BePascalLibName name 'BScrollBar_SetTarget';
function BScrollBar_Target(AObject : TCPlusObject) : TView; cdecl; external BePascalLibName name 'BScrollBar_Target';
function BScrollBar_Orientation(AObject : TCPlusObject) : TOrientation; cdecl; external BePascalLibName name 'BScrollBar_Orientation';
procedure BScrollBar_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_MessageReceived';
procedure BScrollBar_MouseDown(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_MouseDown';
procedure BScrollBar_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_MouseUp';
procedure BScrollBar_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TMessage); cdecl; external BePascalLibName name 'BScrollBar_MouseMoved';
procedure BScrollBar_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_DetachedFromWindow';
procedure BScrollBar_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_Draw';
procedure BScrollBar_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_FrameMoved';
procedure BScrollBar_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BScrollBar_FrameResized';
function BScrollBar_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BScrollBar_ResolveSpecifier';
procedure BScrollBar_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_ResizeToPreferred';
procedure BScrollBar_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BScrollBar_GetPreferredSize';
procedure BScrollBar_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BScrollBar_MakeFocus';
procedure BScrollBar_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_AllAttached';
procedure BScrollBar_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollBar_AllDetached';
function BScrollBar_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BScrollBar_GetSupportedSuites';
function BScrollBar_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BScrollBar_Perform';

implementation

constructor  TScrollBar.Create(frame : TRect; name : pchar; atarget : TView; min,max : real; direction : Torientation);
begin
   CreatePas;
  CPlusObject := BScrollBar_Create(Self,frame.CPlusObject, name, target.CPlusObject,min,max, direction );
end;

constructor  TScrollBar.Create_1(data : TMessage);
begin
  CreatePas;
  CPlusObject := BScrollBar_Create_1(Self, data.CPlusObject);
end;

destructor  TScrollBar.Destroy;
begin
  BScrollBar_Free(CPlusObject);
  inherited;
end;

function  TScrollBar.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BScrollBar_Instantiate(CPlusObject, data.CPlusObject);
end;

function  TScrollBar.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BScrollBar_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure  TScrollBar.AttachedToWindow;
begin
 // BScrollBar_AttachedToWindow(CPlusObject);
end;

procedure  TScrollBar.SetValue(avalue : double);
begin
  BScrollBar_SetValue(CPlusObject, avalue);
end;

function  TScrollBar.Value : double;
begin
  Result := BScrollBar_Value(CPlusObject);
end;

procedure  TScrollBar.SetProportion( avalue: double);
begin
  BScrollBar_SetProportion(CPlusObject, avalue);
end;

function  TScrollBar.Proportion : double;
begin
  Result := BScrollBar_Proportion(CPlusObject);
end;

procedure  TScrollBar.ValueChanged(newValue : double);
begin
  BScrollBar_ValueChanged(CPlusObject, newValue);
end;

procedure  TScrollBar.SetRange(min : double; max : double);
begin
  BScrollBar_SetRange(CPlusObject, min, max);
end;

procedure  TScrollBar.GetRange(min : double; max : double);
begin
  BScrollBar_GetRange(CPlusObject, min, max);
end;

procedure  TScrollBar.SetSteps(smallStep : double; largeStep : double);
begin
  BScrollBar_SetSteps(CPlusObject, smallStep, largeStep);
end;

procedure  TScrollBar.GetSteps(smallStep : double; largeStep : double);
begin
  BScrollBar_GetSteps(CPlusObject, smallStep, largeStep);
end;

procedure  TScrollBar.SetTarget(atarget : TView);
begin
  BScrollBar_SetTarget(CPlusObject, target.CPlusObject);
end;

procedure  TScrollBar.SetTarget(targetName : PChar);
begin
  BScrollBar_SetTarget(CPlusObject, targetName);
end;

function  TScrollBar.Target : TView;
begin
  Result := BScrollBar_Target(CPlusObject);
end;

function  TScrollBar.Orientation : TOrientation;
begin
  Result := BScrollBar_Orientation(CPlusObject);
end;

procedure  TScrollBar.MessageReceived(msg : TMessage);
begin
 // BScrollBar_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure  TScrollBar.MouseDown(pt : TPoint);
begin
//  BScrollBar_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure  TScrollBar.MouseUp(pt : TPoint);
begin
//  BScrollBar_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure  TScrollBar.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
//  BScrollBar_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure  TScrollBar.DetachedFromWindow;
begin
 // BScrollBar_DetachedFromWindow(CPlusObject);
end;

procedure  TScrollBar.Draw(updateRect : TRect);
begin
  //BScrollBar_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure  TScrollBar.FrameMoved(new_position : TPoint);
begin
//  BScrollBar_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure  TScrollBar.FrameResized(new_width : double; new_height : double);
begin
//  BScrollBar_FrameResized(CPlusObject, new_width, new_height);
end;

function  TScrollBar.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BScrollBar_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure  TScrollBar.ResizeToPreferred;
begin
//  BScrollBar_ResizeToPreferred(CPlusObject);
end;

procedure  TScrollBar.GetPreferredSize(width : double; height : double);
begin
  BScrollBar_GetPreferredSize(CPlusObject, width, height);
end;

procedure  TScrollBar.MakeFocus(state : boolean);
begin
  BScrollBar_MakeFocus(CPlusObject, state);
end;

procedure  TScrollBar.AllAttached;
begin
  BScrollBar_AllAttached(CPlusObject);
end;

procedure  TScrollBar.AllDetached;
begin
  BScrollBar_AllDetached(CPlusObject);
end;

function  TScrollBar.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BScrollBar_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function  TScrollBar.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BScrollBar_Perform(CPlusObject, d, arg);
end;


end.
