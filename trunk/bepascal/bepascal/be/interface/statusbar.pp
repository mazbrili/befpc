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
unit statusbar;

interface

uses
     beobj, view, message, archivable, SupportDefs, rect, list,
  handler, messenger,interfacedefs,font,graphicdefs;

type
  TStatusBar = class(TView)
  private
  public
    constructor Create( frame : TRect; 
                                        name : pchar;
								       alabel : Pchar;
								       trailing_label : Pchar);virtual;
    constructor Create(data : TMessage);virtual;
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure AttachedToWindow;override;
    procedure MessageReceived(msg : TMessage);override;
    procedure Draw(updateRect : TRect);override;
    procedure SetBarColor(color : trgb_color);
    procedure SetBarHeight(height : double);
    procedure SetText(str : PChar);
    procedure SetTrailingText(str : PChar);
    procedure SetMaxValue(max : double);
    procedure Update(delta : single; main_text : PChar; trailing_text : PChar);
    procedure Reset(alabel : PChar; trailing_label : PChar);
    function CurrentValue : double;
    function MaxValue : double;
    function BarColor : trgb_color;
    function BarHeight : double;
    function Text : PChar;
    function TrailingText : PChar;
    function GetLabel : PChar;
    function TrailingLabel : PChar;
    procedure MouseDown(pt : TPoint);override;
    procedure MouseUp(pt : TPoint);override;
    procedure WindowActivated(state : boolean);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure DetachedFromWindow;override;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    procedure ResizeToPreferred;override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    procedure AllAttached;override;
    procedure AllDetached;override;
  
  end;

function BStatusBar_Create(AObject : TBeObject;frame : TCPlusObject; 
                                        name : pchar;
								       slabel : Pchar;
								       trailing_label : Pchar): TCPlusObject; cdecl; external BePascalLibName name 'BStatusBar_Create';
function BStatusBar_Create(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BStatusBar_Create';
procedure BStatusBar_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_Free';
function BStatusBar_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BStatusBar_Instantiate';
function BStatusBar_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BStatusBar_Archive';
procedure BStatusBar_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_AttachedToWindow';
procedure BStatusBar_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_MessageReceived';
procedure BStatusBar_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_Draw';
procedure BStatusBar_SetBarColor(AObject : TCPlusObject; color : trgb_color); cdecl; external BePascalLibName name 'BStatusBar_SetBarColor';
procedure BStatusBar_SetBarHeight(AObject : TCPlusObject; height : double); cdecl; external BePascalLibName name 'BStatusBar_SetBarHeight';
procedure BStatusBar_SetText(AObject : TCPlusObject; str : PChar); cdecl; external BePascalLibName name 'BStatusBar_SetText';
procedure BStatusBar_SetTrailingText(AObject : TCPlusObject; str : PChar); cdecl; external BePascalLibName name 'BStatusBar_SetTrailingText';
procedure BStatusBar_SetMaxValue(AObject : TCPlusObject; max : double); cdecl; external BePascalLibName name 'BStatusBar_SetMaxValue';
procedure BStatusBar_Update(AObject : TCPlusObject; delta : single; main_text : PChar; trailing_text : PChar); cdecl; external BePascalLibName name 'BStatusBar_Update';
procedure BStatusBar_Reset(AObject : TCPlusObject; alabel : PChar; trailing_label : PChar); cdecl; external BePascalLibName name 'BStatusBar_Reset';
function BStatusBar_CurrentValue(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BStatusBar_CurrentValue';
function BStatusBar_MaxValue(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BStatusBar_MaxValue';
function BStatusBar_BarColor(AObject : TCPlusObject) : trgb_color; cdecl; external BePascalLibName name 'BStatusBar_BarColor';
function BStatusBar_BarHeight(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BStatusBar_BarHeight';
function BStatusBar_Text(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStatusBar_Text';
function BStatusBar_TrailingText(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStatusBar_TrailingText';
function BStatusBar_Label(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStatusBar_Label';
function BStatusBar_TrailingLabel(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStatusBar_TrailingLabel';
procedure BStatusBar_MouseDown(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_MouseDown';
procedure BStatusBar_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_MouseUp';
procedure BStatusBar_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BStatusBar_WindowActivated';
procedure BStatusBar_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TMessage); cdecl; external BePascalLibName name 'BStatusBar_MouseMoved';
procedure BStatusBar_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_DetachedFromWindow';
procedure BStatusBar_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_FrameMoved';
procedure BStatusBar_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BStatusBar_FrameResized';
function BStatusBar_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BStatusBar_ResolveSpecifier';
procedure BStatusBar_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_ResizeToPreferred';
procedure BStatusBar_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BStatusBar_GetPreferredSize';
procedure BStatusBar_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BStatusBar_MakeFocus';
procedure BStatusBar_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_AllAttached';
procedure BStatusBar_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStatusBar_AllDetached';
function BStatusBar_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BStatusBar_GetSupportedSuites';

implementation

constructor TStatusBar.Create(frame : TRect; 
                                        name : pchar;
								       alabel : Pchar;
								       trailing_label : Pchar);
begin
  CreatePas;
  CPlusObject := BStatusBar_Create(Self,frame.CPlusObject,name,alabel,trailing_label);
end;

constructor TStatusBar.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BStatusBar_Create(Self, data.CPlusObject);
end;

destructor TStatusBar.Destroy;
begin
  BStatusBar_Free(CPlusObject);
  inherited;
end;

function TStatusBar.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BStatusBar_Instantiate(CPlusObject, data.CPlusObject);
end;

function TStatusBar.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BStatusBar_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TStatusBar.AttachedToWindow;
begin
  //BStatusBar_AttachedToWindow(CPlusObject);
end;

procedure TStatusBar.MessageReceived(msg : TMessage);
begin
  //BStatusBar_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TStatusBar.Draw(updateRect : TRect);
begin
//  BStatusBar_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure TStatusBar.SetBarColor(color : trgb_color);
begin
  BStatusBar_SetBarColor(CPlusObject, color);
end;

procedure TStatusBar.SetBarHeight(height : double);
begin
  BStatusBar_SetBarHeight(CPlusObject, height);
end;

procedure TStatusBar.SetText(str : PChar);
begin
  BStatusBar_SetText(CPlusObject, str);
end;

procedure TStatusBar.SetTrailingText(str : PChar);
begin
  BStatusBar_SetTrailingText(CPlusObject, str);
end;

procedure TStatusBar.SetMaxValue(max : double);
begin
  BStatusBar_SetMaxValue(CPlusObject, max);
end;

procedure TStatusBar.Update(delta : single; main_text : PChar; trailing_text : PChar);
begin
  BStatusBar_Update(CPlusObject, delta, main_text, trailing_text);
end;

procedure TStatusBar.Reset(alabel : PChar; trailing_label : PChar);
begin
  BStatusBar_Reset(CPlusObject, alabel, trailing_label);
end;

function TStatusBar.CurrentValue : double;
begin
  Result := BStatusBar_CurrentValue(CPlusObject);
end;

function TStatusBar.MaxValue : double;
begin
  Result := BStatusBar_MaxValue(CPlusObject);
end;

function TStatusBar.BarColor : trgb_color;
begin
  Result := BStatusBar_BarColor(CPlusObject);
end;

function TStatusBar.BarHeight : double;
begin
  Result := BStatusBar_BarHeight(CPlusObject);
end;

function TStatusBar.Text : PChar;
begin
  Result := BStatusBar_Text(CPlusObject);
end;

function TStatusBar.TrailingText : PChar;
begin
  Result := BStatusBar_TrailingText(CPlusObject);
end;

function TStatusBar.GetLabel : PChar;
begin
  Result := BStatusBar_Label(CPlusObject);
end;

function TStatusBar.TrailingLabel : PChar;
begin
  Result := BStatusBar_TrailingLabel(CPlusObject);
end;

procedure TStatusBar.MouseDown(pt : TPoint);
begin
//  BStatusBar_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure TStatusBar.MouseUp(pt : TPoint);
begin
//  BStatusBar_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TStatusBar.WindowActivated(state : boolean);
begin
//  BStatusBar_WindowActivated(CPlusObject, state);
end;

procedure TStatusBar.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
//  BStatusBar_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TStatusBar.DetachedFromWindow;
begin
//  BStatusBar_DetachedFromWindow(CPlusObject);
end;

procedure TStatusBar.FrameMoved(new_position : TPoint);
begin
//  BStatusBar_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TStatusBar.FrameResized(new_width : double; new_height : double);
begin
// BStatusBar_FrameResized(CPlusObject, new_width, new_height);
end;

function TStatusBar.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
//  Result := BStatusBar_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure TStatusBar.ResizeToPreferred;
begin
  BStatusBar_ResizeToPreferred(CPlusObject);
end;

procedure TStatusBar.GetPreferredSize(width : double; height : double);
begin
  BStatusBar_GetPreferredSize(CPlusObject, width, height);
end;

procedure TStatusBar.MakeFocus(state : boolean);
begin
  BStatusBar_MakeFocus(CPlusObject, state);
end;

procedure TStatusBar.AllAttached;
begin
  BStatusBar_AllAttached(CPlusObject);
end;

procedure TStatusBar.AllDetached;
begin
  BStatusBar_AllDetached(CPlusObject);
end;


end.
