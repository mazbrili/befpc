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
    
   24/5/2003 : Eric : Add Show,Hide,IsHidden 
}

unit View;

interface

uses
  beobj, handler, rect, os, application, appdefs, message,
  graphicdefs;
  
type
//  TWindow = class(TBeObject);
  BView = class(BHandler)
  public
    constructor Create(frame : BRect; name : PChar; resizingMode, flags : Cardinal);
    destructor Destroy; override;
    // hook functions
    procedure AllAttached; virtual;
    procedure AllDetached; virtual;
    procedure AttachedToWindow; virtual;
    procedure DetachedFromWindow; virtual;
    procedure Draw(updateRect : BRect); virtual;
    procedure DrawAfterChildren(updateRect : BRect); virtual;
    procedure FrameMoved(parenBPoint : BPoint); virtual;
    procedure FrameResized(width, height : double); virtual;
    procedure GetPreferredSize(var width : double; var height : double); virtual;
    procedure ResizeToPreferred; virtual;
    procedure KeyDown(bytes : PChar; numBytes : integer); virtual;
    procedure KeyUp(bytes : PChar; numBytes : integer); virtual;
    procedure MouseDown(point : BPoint); virtual;
    procedure MouseMoved(point : BPoint; transit : Cardinal; message : BMessage); virtual;
    procedure MouseUp(point : BPoint); virtual;
    procedure Pulse; virtual;
//    procedure TargetedByScrollView(scroller : TScrollView); virtual; // Need BScrollView
    procedure WindowActivated(active : boolean); virtual;
    procedure MessageReceived(aMessage : BMessage); override;
    // End hook functions
    function RemoveSelf : boolean;
    procedure AddChild(aView, before : BView);
    function RemoveChild(aView : BView) : boolean;
    function CountChildren : integer;
    function ChildAt(index : integer) : BView;
    function NextSibling : BView;
    function PreviousSibling : BView;
//    function Window : TWindow;
    procedure SetViewColor(rgb_color : RGB_color);
    procedure Show;
    procedure Hide;
    function IsHidden : Boolean;
  end;

function BView_Create(AObject : TObject; frame : TCPlusObject; name : PChar;
  resizingMode, flags : cardinal) : TCplusObject; cdecl; external BePascalLibName name 'BView_Create_1';
procedure BView_Free(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BView_Free';
function BView_RemoveSelf(CPlusObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BView_RemoveSelf';
procedure BView_AddChild(CPlusObject : TCPlusObject; aView : TCPlusObject; before : TCPlusObject); cdecl; external BePascalLibName name 'BView_AddChild';
function BView_RemoveChild(CPlusObject : TCPlusObject; aView : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BView_RemoveChild';
function BView_CountChildren(CPlusObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BView_CountChildren';
function BView_NextSibling(CPlusObject : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BView_NextSibling';
function BView_PreviousSibling(CPlusObject : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BView_NextSibling';
function BView_ChildAt(CPlusObject : TCPlusObject; index : integer) : TCPlusObject; cdecl; external BePascalLibName name 'BView_ChildAt';
function BView_Window(CPlusObject : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BView_Window';
procedure BView_Draw(CPlusObject : TCPlusObject; aRect : TCPlusObject); cdecl; external BePascalLibName name 'BView_Draw';
procedure BView_SeBViewColor(CPlusObject : TCPlusObject; c : RGB_color); cdecl; external BePascalLibName name 'BView_SetViewColor';
procedure BView_Show(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BView_Show';
procedure BView_Hide(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BView_Hide';
function BView_IsHidden(CPlusObject : TCPlusObject) : Boolean; cdecl; external BePascalLibName name 'BView_IsHidden';

var
    // resizingMode mask
  B_FOLLOW_NONE : Cardinal;
  B_FOLLOW_ALL_SIDES : Cardinal;
  
  B_FOLLOW_ALL : Cardinal;
  
  B_FOLLOW_LEFT : Cardinal;
  B_FOLLOW_RIGHT : Cardinal;
  B_FOLLOW_LEFT_RIGHT : Cardinal;
  B_FOLLOW_H_CENTER : Cardinal;
  
  B_FOLLOW_TOP : Cardinal;
  B_FOLLOW_BOTTOM : Cardinal;
  B_FOLLOW_TOP_BOTTOM : Cardinal;
  B_FOLLOW_V_CENTER : Cardinal; 

const
    // flags
  B_FULL_UPDATE_ON_RESIZE 	: Cardinal = $80000000;//31;
  _B_RESERVED1_ 			: Cardinal = $40000000;//30;
  B_WILL_DRAW				: Cardinal = $20000000;//29;
  B_PULSE_NEEDED			: Cardinal = $10000000;//28;
  B_NAVIGABLE_JUMP			: Cardinal = $08000000;//27;
  B_FRAME_EVENTS			: Cardinal = $04000000;//26;
  B_NAVIGABLE				: Cardinal = $02000000;//25;
  B_SUBPIXEL_PRECISE		: Cardinal = $00800000;//24;
  B_DRAW_ON_CHILDREN		: Cardinal = $00400000;//23;
  _B_RESERVED7_				: Cardinal = $00200000;//22;

  B_FONT_FAMILY_AND_STYLE	= 1;
  B_FONT_SIZE				= 2;
  B_FONT_SHEAR				= 4;
  B_FONT_ROTATION			= 8;
  B_FONT_SPACING     		= 16;
  B_FONT_ENCODING			= 32;
  B_FONT_FACE				= 64;
  B_FONT_FLAGS				= 128;
  B_FONT_ALL				= 255;
  
implementation

var
  View_AllAttached_hook : Pointer; cvar; external;
  View_AllDetached_hook : Pointer; cvar; external;
  View_AttachedToWindow_hook : Pointer; cvar; external;
  View_DetachedFromWindow_hook : Pointer; cvar; external;
  View_Draw_hook : Pointer; cvar; external;
  View_DrawAfterChildren_hook : Pointer; cvar; external;
  View_FrameMoved_hook : Pointer; cvar; external;
  View_FrameResized_hook : Pointer; cvar; external;
  View_GetPreferredSize_hook : Pointer; cvar; external;
  View_ResizeToPreferred_hook : Pointer; cvar; external;
  View_KeyDown_hook : Pointer; cvar; external;
  View_KeyUp_hook : Pointer; cvar; external;
  View_MouseDown_hook : Pointer; cvar; external;
  View_MouseMoved_hook : Pointer; cvar; external;
  View_MouseUp_hook : Pointer; cvar; external;
  View_Pulse_hook : Pointer; cvar; external;
  View_TargetedByScrollView_hook : Pointer; cvar; external;
  View_WindowActivated_hook : Pointer; cvar; external;

// View hook functions
{
  View_AllAttached_hook
  View_AllDetached_hook
  View_AttachedToWindow_hook
  View_DetachedFromWindow_hook
  View_Draw_hook
  View_DrawAfterChildren_hook
  View_FrameMoved_hook
  View_FrameResized_hook
  View_GetPreferredSize_hook
  View_ResizeToPreferred_hook
  View_KeyDown_hook
  View_KeyUp_hook
  View_MouseDown_hook
  View_MouseMoved_hook
  View_MouseUp_hook
  View_Pulse_hook
  View_TargetedByScrollView_hook
  View_WindowActivated_hook}
  
 
constructor BView.Create(frame : BRect; name : PChar; resizingMode, flags : Cardinal);
begin
  inherited Create;
  CPlusObject := BView_Create(Self, frame.CPlusObject, name, resizingMode, flags);
end;

destructor BView.Destroy;
begin
  BView_Free(Self.CPlusObject);  
  inherited;
end;

// Hook functions
procedure BView.AllAttached; 
begin
end;

procedure BView.AllDetached;
begin
end;

procedure BView.AttachedToWindow;
begin
end;

procedure BView.DetachedFromWindow;
begin
end;

procedure BView.Draw(updateRect : BRect);
begin
  SendText('Drawing view');
  
end;

procedure BView.DrawAfterChildren(updateRect : BRect);
begin
end;

procedure BView.FrameMoved(parenBPoint : BPoint);
begin
end;

procedure BView.FrameResized(width, height : double);
begin
end;

procedure BView.GetPreferredSize(var width : double; var height : double);
begin
end;

procedure BView.ResizeToPreferred; 
begin
end;

procedure BView.KeyDown(bytes : PChar; numBytes : integer);
begin
end;

procedure BView.KeyUp(bytes : PChar; numBytes : integer);
begin
end;

procedure BView.MouseDown(point : BPoint);
begin
end;

procedure BView.MouseMoved(point : BPoint; transit : Cardinal; message : BMessage);
begin
end;

procedure BView.MouseUp(point : BPoint);
begin
end;

procedure BView.Pulse;
begin
end;

//    procedure BView.TargetedByScrollView(); // Need BScrollView
//begin
//end;

procedure BView.WindowActivated(active : boolean);
begin
end;

procedure BView.MessageReceived(aMessage : BMessage);
begin
  inherited;
end;

function BView.RemoveSelf : boolean;
begin
  Result := BView_RemoveSelf(Self.CPlusObject);
end;

procedure BView.AddChild(aView, before : BView);
begin
  if before <> nil then
    BView_AddChild(Self.CPlusObject, aView.CPlusObject, before.CPlusObject)
  else
    BView_AddChild(Self.CPlusObject, aView.CPlusObject, nil);
end;

function BView.RemoveChild(aView : BView) : boolean;
begin
  Result := BView_RemoveChild(Self.CPlusObject, aView);
end;

function BView.CountChildren : integer;
begin
  Result := BView_CountChildren(Self.CPlusObject);
end;

function BView.ChildAt(index : integer) : BView;
begin
  Result := BView.Wrap(BView_ChildAt(Self.CPlusObject, index));
end;

function BView.NextSibling : BView;
begin
  Result := BView.Wrap(BView_NextSibling(Self.CPlusObject));
end;

function BView.PreviousSibling : BView;
begin
  Result := BView.Wrap(BView_PreviousSibling(Self.CPlusObject));
end;

{function BView.Window : TWindow;
begin
  Result := TWindow.Wrap(BView_Window(Self.CPlusObject));
end;}

procedure BView.SetViewColor(rgb_color : RGB_color);
begin
  BView_SeBViewColor(Self.CPlusObject, rgb_color);  
end;

procedure BView.Show;
begin
  BView_Show(Self.CPlusObject);  
end;

procedure BView.Hide;
begin
  BView_Hide(Self.CPlusObject);  
end;

function BView.IsHidden : Boolean;
begin
  Result:=BView_IsHidden(Self.CPlusObject);  
end;

////////////////////////////////////////////////////////////////////////
// Hook functions
////////////////////////////////////////////////////////////////////////
procedure View_AllAttached_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.AllAttached;
end;

procedure View_AllDetached_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.AllDetached;
end;

procedure View_AttachedToWindow_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.AttachedToWindow;
end;

procedure View_DetachedFromWindow_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.DetachedFromWindow;
end;

procedure View_Draw_hook_func(View : BView; aRect : TCPlusObject); cdecl;
var
  Rect : BRect;
begin
  Rect := BRect.Wrap(aRect);
  try
  if View <> nil then
    View.Draw(Rect);
  finally
    Rect.UnWrap;
  end;
end;

procedure View_DrawAfterChildren_hook_func(View : BView; aRect : TCPlusObject); cdecl;
var
  Rect : BRect;
begin
  Rect := BRect.Wrap(aRect);
  try
    if View <> nil then
      View.DrawAfterChildren(Rect);
  finally
    Rect.UnWrap;
  end;
end;

procedure View_FrameMoved_hook_func(View : BView; aPoint : TCPlusObject); cdecl;
var
  Point : BPoint;
begin
  Point := BPoint.Wrap(aPoint);
  try
    if View <> nil then
      View.FrameMoved(Point);
  finally
    Point.UnWrap;
  end;
end;

procedure View_FrameResized_hook_func(View : BView; width, height : double); cdecl;
begin
  if View <> nil then
    View.FrameResized(width, height);
end;

procedure View_GetPreferredSize_hook_func(View : BView; var width, height : double); cdecl;
begin
  if View <> nil then
    View.GetPreferredSize(width, height);
end;

procedure View_ResizeToPreferred_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.ResizeToPreferred;
end;

procedure View_KeyDown_hook_func(View : BView; bytes : PChar; numBytes : integer); cdecl;
begin
  if View <> nil then
    View.KeyDown(bytes, numBytes);
end;

procedure View_KeyUp_hook_func(View : BView; bytes : PChar; numBytes : integer); cdecl;
begin
  if View <> nil then
    View.KeyUp(bytes, numBytes);
end;

procedure View_MouseDown_hook_func(View : BView; aPoint : TCPlusObject); cdecl;
var
  Point : BPoint;
begin
  Point := BPoint.Wrap(aPoint);
  try
    if View <> nil then
      View.MouseDown(Point);
  finally
    Point.UnWrap;
  end;
end;

procedure View_MouseMoved_hook_func(View : BView; aPoint : TCPlusObject; transit : Cardinal; aMessage : TCPlusObject); cdecl;
var
  Point : BPoint;
  Message : BMessage;  
begin
  Point := BPoint.Wrap(aPoint);
  try
    Message := BMessage.Wrap(aMessage);
    try
      if View <> nil then
        View.MouseMoved(Point, transit, Message);
    finally
      Message.UnWrap;
    end;
  finally
    Point.UnWrap;
  end;
end;

procedure View_MouseUp_hook_func(View : BView; aPoint : TCPlusObject); cdecl;
var
  Point : BPoint;
begin
  Point := BPoint.Wrap(aPoint);
  try
    if View <> nil then
      View.MouseDown(Point);
  finally
    Point.UnWrap;
  end;
end;

procedure View_Pulse_hook_func(View : BView); cdecl;
begin
  if View <> nil then
    View.Pulse;
end;

//procedure View_TargetedByScrollView_hook_func(View : BView; scroller : TScrollView); cdecl;
//var
//  ScrollView : TScrollView;
//begin
//  ScrollView := TScrollView.Wrap(scroller);
//  try
//    if View <> nil then  
//      View.TargetedByScrollView(ScrollView);
//  finally
//    ScrollView.UnWrap;
//  end; 
//end;

procedure View_WindowActivated_hook_func(View : BView; active : boolean); cdecl;
begin
  if View <> nil then
    View.WindowActivated(active);
end;

var
  _B_FOLLOW_NONE : Cardinal; cvar; external;
  _B_FOLLOW_ALL_SIDES : Cardinal; cvar; external;
  
  _B_FOLLOW_ALL : Cardinal; cvar; external;
  
  _B_FOLLOW_LEFT : Cardinal; cvar; external;
  _B_FOLLOW_RIGHT : Cardinal; cvar; external;
  _B_FOLLOW_LEFT_RIGHT : Cardinal; cvar; external;
  _B_FOLLOW_H_CENTER : Cardinal; cvar; external;
  
  _B_FOLLOW_TOP : Cardinal; cvar; external;
  _B_FOLLOW_BOTTOM : Cardinal; cvar; external;
  _B_FOLLOW_TOP_BOTTOM : Cardinal; cvar; external;
  _B_FOLLOW_V_CENTER : Cardinal; cvar; external;

initialization
  B_FOLLOW_NONE := _B_FOLLOW_NONE;
  B_FOLLOW_ALL_SIDES := _B_FOLLOW_ALL_SIDES;
  
  B_FOLLOW_ALL := _B_FOLLOW_ALL;
  
  B_FOLLOW_LEFT := _B_FOLLOW_LEFT;
  B_FOLLOW_RIGHT := _B_FOLLOW_RIGHT;
  B_FOLLOW_LEFT_RIGHT := _B_FOLLOW_LEFT_RIGHT;
  B_FOLLOW_H_CENTER := _B_FOLLOW_H_CENTER;
  
  B_FOLLOW_TOP := _B_FOLLOW_TOP;
  B_FOLLOW_BOTTOM := _B_FOLLOW_BOTTOM;
  B_FOLLOW_TOP_BOTTOM := _B_FOLLOW_TOP_BOTTOM;
  B_FOLLOW_V_CENTER := _B_FOLLOW_V_CENTER;
  
    // Connecting hook functions
  View_AllAttached_hook := @View_AllAttached_hook_func;
  View_AllDetached_hook := @View_AllDetached_hook_func;
  View_AttachedToWindow_hook := @View_AttachedToWindow_hook_func;
  View_DetachedFromWindow_hook := @View_DetachedFromWindow_hook_func;
  View_Draw_hook := @View_Draw_hook_func;
  View_DrawAfterChildren_hook := @View_DrawAfterChildren_hook_func;
  View_FrameMoved_hook := @View_FrameMoved_hook_func;
  View_FrameResized_hook := @View_FrameResized_hook_func;
  View_GetPreferredSize_hook := @View_GetPreferredSize_hook_func;
  View_ResizeToPreferred_hook := @View_ResizeToPreferred_hook_func;
  View_KeyDown_hook := @View_KeyDown_hook_func;
  View_KeyUp_hook := @View_KeyUp_hook_func;
  View_MouseDown_hook := @View_MouseDown_hook_func;
  View_MouseMoved_hook := @View_MouseMoved_hook_func;
  View_MouseUp_hook := @View_MouseUp_hook_func;
  View_Pulse_hook := @View_Pulse_hook_func;
//  View_TargetedByScrollView_hook := @View_TargetedByScrollView_hook_func;
  View_WindowActivated_hook := @View_WindowActivated_hook_func;

end.