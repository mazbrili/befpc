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
unit tabview;

interface

uses
  beobj, interfacedefs,view,Message, Archivable, SupportDefs, Rect, Handler,font;

const
	B_TAB_FIRST = 999;
	B_TAB_FRONT=1;
	B_TAB_ANY=2;
type
  TTab = class(TBeObject)
  private
  public
    constructor Create(View : TView);virtual;
    constructor Create_1(data : TMessage);virtual;
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    function Perform(d : Cardinal; arg : Pointer) : TStatus_t;
    function GetLabel : PChar;
    procedure SetLabel(alabel : PChar);
    function IsSelected : boolean;
    procedure Select(owner : TView);
    procedure Deselect;
    procedure SetEnabled(aon : boolean);
    function IsEnabled : boolean;
    procedure MakeFocus(infocus : boolean);
    function IsFocus : boolean;
    procedure SetView(contents : TView);
    function GetView : TView;
    procedure DrawFocusMark(owner : TView; tabFrame : TRect);
    procedure DrawLabel(owner : TView; tabFrame : TRect);
    procedure DrawTab(owner : TView; tabFrame : TRect; position : byte; full : boolean);
  end;


type
  TTabView = class(TView)
  private
  public
    destructor Destroy;override;
    constructor Create(frame : TRect; name : Pchar; width : Tbutton_width; resizingMode : cardinal; flags : cardinal);virtual;
    constructor Create(msg : TMessage);virtual;
    function Instantiate( msg: TMessage) : TArchivable;
    function Archive( msg : TMessage; deep : boolean) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
    procedure WindowActivated(state : boolean);override;
    procedure AttachedToWindow;override;
    procedure AllAttached;override;
    procedure AllDetached;override;
    procedure DetachedFromWindow;override;
    procedure MessageReceived(msg : TMessage);override;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(w : double; h : double);override;
    procedure KeyDown(bytes : PChar; n : integer);override;
    procedure MouseDown( pt: TPoint);override;
    procedure MouseUp( pt: TPoint);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure Pulse;override;
    procedure Select(tabIndex : integer);
    function Selection : integer;
    procedure MakeFocus(focusState : boolean);
    procedure SetFocusTab(tabIndex : integer; focusState : boolean);
    function FocusTab : integer;
    procedure Draw( rect: TRect);override;
    function DrawTabs : TRect;
    procedure DrawBox(selectedTabFrame : TRect);
    function TabFrame(tabIndex : integer) : TRect;
    procedure SetFlags(flags : Cardinal);
    procedure SetResizingMode(mode : Cardinal);
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred;override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure AddTab(tabContents : TView; tab : TTab);
    function RemoveTab(tabIndex : integer) : TTab;
    function TabAt(tabIndex : integer) : TTab;
    procedure SetTabWidth(s : Tbutton_width);
    function TabWidth : Tbutton_width;
    procedure SetTabHeight(height : double);
    function TabHeight : double;
    function ContainerView : TView;
    function CountTabs : integer;
    function ViewForTab(tabIndex : integer) : TView;
  end;

function BTab_Create(AObject : TBeObject;View : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BTab_Create';
procedure BTab_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTab_Free';
function BTab_Create_1(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BTab_Create_1';
function BTab_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BTab_Instantiate';
function BTab_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BTab_Archive';
function BTab_Perform(AObject : TCPlusObject; d : Cardinal; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BTab_Perform';
function BTab_Label(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BTab_Label';
procedure BTab_SetLabel(AObject : TCPlusObject; alabel : PChar); cdecl; external BePascalLibName name 'BTab_SetLabel';
function BTab_IsSelected(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTab_IsSelected';
procedure BTab_Select(AObject : TCPlusObject; owner : TCPlusObject); cdecl; external BePascalLibName name 'BTab_Select';
procedure BTab_Deselect(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTab_Deselect';
procedure BTab_SetEnabled(AObject : TCPlusObject; aon : boolean); cdecl; external BePascalLibName name 'BTab_SetEnabled';
function BTab_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTab_IsEnabled';
procedure BTab_MakeFocus(AObject : TCPlusObject; infocus : boolean); cdecl; external BePascalLibName name 'BTab_MakeFocus';
function BTab_IsFocus(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTab_IsFocus';
procedure BTab_SetView(AObject : TCPlusObject; contents : TCPlusObject); cdecl; external BePascalLibName name 'BTab_SetView';
function BTab_View(AObject : TCPlusObject) : TView; cdecl; external BePascalLibName name 'BTab_View';
procedure BTab_DrawFocusMark(AObject : TCPlusObject; owner : TCPlusObject; tabFrame : TCPlusObject); cdecl; external BePascalLibName name 'BTab_DrawFocusMark';
procedure BTab_DrawLabel(AObject : TCPlusObject; owner : TCPlusObject; tabFrame : TCPlusObject); cdecl; external BePascalLibName name 'BTab_DrawLabel';
procedure BTab_DrawTab(AObject : TCPlusObject; owner : TCPlusObject; tabFrame : TCPlusObject; position : byte; full : boolean); cdecl; external BePascalLibName name 'BTab_DrawTab';

procedure BTabView_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_Free';
function BTabView_Create(AObject : TBeObject;frame : TCPlusObject; name : Pchar; width : Integer; resizingMode : cardinal; flags : cardinal): TCPlusObject; cdecl; external BePascalLibName name 'BTabView_Create';
function BTabView_Create_1(AObject : TBeObject; msg : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BTabView_Create_1';
function BTabView_Instantiate(AObject : TCPlusObject; msg : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BTabView_Instantiate';
function BTabView_Archive(AObject : TCPlusObject; msg : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BTabView_Archive';
function BTabView_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BTabView_Perform';
procedure BTabView_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BTabView_WindowActivated';
procedure BTabView_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_AttachedToWindow';
procedure BTabView_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_AllAttached';
procedure BTabView_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_AllDetached';
procedure BTabView_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_DetachedFromWindow';
procedure BTabView_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_MessageReceived';
procedure BTabView_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_FrameMoved';
procedure BTabView_FrameResized(AObject : TCPlusObject; w : double; h : double); cdecl; external BePascalLibName name 'BTabView_FrameResized';
procedure BTabView_KeyDown(AObject : TCPlusObject; bytes : PChar; n : integer); cdecl; external BePascalLibName name 'BTabView_KeyDown';
procedure BTabView_MouseDown(AObject : TCPlusObject;  pt: TCPlusObject); cdecl; external BePascalLibName name 'BTabView_MouseDown';
procedure BTabView_MouseUp(AObject : TCPlusObject;  pt: TCPlusObject); cdecl; external BePascalLibName name 'BTabView_MouseUp';
procedure BTabView_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_MouseMoved';
procedure BTabView_Pulse(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_Pulse';
procedure BTabView_Select(AObject : TCPlusObject; tabIndex : integer); cdecl; external BePascalLibName name 'BTabView_Select';
//function BTabView_Selection(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTabView_Selection';
procedure BTabView_MakeFocus(AObject : TCPlusObject; focusState : boolean); cdecl; external BePascalLibName name 'BTabView_MakeFocus';
procedure BTabView_SetFocusTab(AObject : TCPlusObject; tabIndex : integer; focusState : boolean); cdecl; external BePascalLibName name 'BTabView_SetFocusTab';
function BTabView_FocusTab(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTabView_FocusTab';
procedure BTabView_Draw(AObject : TCPlusObject; rect : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_Draw';
//function BTabView_DrawTabs(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BTabView_DrawTabs';
procedure BTabView_DrawBox(AObject : TCPlusObject; selectedTabFrame : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_DrawBox';
function BTabView_TabFrame(AObject : TCPlusObject; tabIndex : integer) : TRect; cdecl; external BePascalLibName name 'BTabView_TabFrame';
procedure BTabView_SetFlags(AObject : TCPlusObject; flags : Cardinal); cdecl; external BePascalLibName name 'BTabView_SetFlags';
procedure BTabView_SetResizingMode(AObject : TCPlusObject; mode : Cardinal); cdecl; external BePascalLibName name 'BTabView_SetResizingMode';
procedure BTabView_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BTabView_GetPreferredSize';
procedure BTabView_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_ResizeToPreferred';
function BTabView_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properto : PChar) : THandler; cdecl; external BePascalLibName name 'BTabView_ResolveSpecifier';
function BTabView_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BTabView_GetSupportedSuites';
procedure BTabView_AddTab(AObject : TCPlusObject; tabContents : TCPlusObject; tab : TCPlusObject); cdecl; external BePascalLibName name 'BTabView_AddTab';
function BTabView_RemoveTab(AObject : TCPlusObject; tabIndex : integer) : TTab; cdecl; external BePascalLibName name 'BTabView_RemoveTab';
function BTabView_TabAt(AObject : TCPlusObject; tabIndex : integer) : TTab; cdecl; external BePascalLibName name 'BTabView_TabAt';
procedure BTabView_SetTabWidth(AObject : TCPlusObject; s : Tbutton_width); cdecl; external BePascalLibName name 'BTabView_SetTabWidth';
function BTabView_TabWidth(AObject : TCPlusObject) : Tbutton_width; cdecl; external BePascalLibName name 'BTabView_TabWidth';
procedure BTabView_SetTabHeight(AObject : TCPlusObject; height : double); cdecl; external BePascalLibName name 'BTabView_SetTabHeight';
function BTabView_TabHeight(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BTabView_TabHeight';
function BTabView_ContainerView(AObject : TCPlusObject) : TView; cdecl; external BePascalLibName name 'BTabView_ContainerView';
function BTabView_CountTabs(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTabView_CountTabs';
function BTabView_ViewForTab(AObject : TCPlusObject; tabIndex : integer) : TView; cdecl; external BePascalLibName name 'BTabView_ViewForTab';

implementation

var
 TabView_AddTab_hook : Pointer; cvar; external;
 TabView_Draw_hook : Pointer; cvar; external;
 TabView_DrawBox_hook : Pointer; cvar; external;
 TabView_DrawTabs_hook : Pointer; cvar; external;
 TabView_MakeFocus_hook : Pointer; cvar; external;
 TabView_RemoveTab_hook : Pointer; cvar; external;
 TabView_Select_hook: Pointer; cvar; external;
 TabView_SetFocusTab_hook : Pointer; cvar; external;
 TabView_SetTabHeight_hook : Pointer; cvar; external;
 TabView_SetTabWidth_hook : Pointer; cvar; external;
 TabView_TabAt_hook : Pointer; cvar; external;
 TabView_TabFrame_hook : Pointer; cvar; external;


constructor TTab.Create(View : TView);
begin
  CreatePas;
  CPlusObject := BTab_Create(Self,View.CPlusObject);
end;

destructor TTab.Destroy;
begin
  BTab_Free(CPlusObject);
  inherited;
end;

constructor TTab.Create_1(data : TMessage);
begin
  CreatePas;
  CPlusObject := BTab_Create_1(Self, data.CPlusObject);
end;

function TTab.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BTab_Instantiate(CPlusObject, data.CPlusObject);
end;

function TTab.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BTab_Archive(CPlusObject, data.CPlusObject, deep);
end;

function TTab.Perform(d : Cardinal; arg : Pointer) : TStatus_t;
begin
  Result := BTab_Perform(CPlusObject, d, arg);
end;

function TTab.GetLabel : PChar;
begin
  Result := BTab_Label(CPlusObject);
end;

procedure TTab.SetLabel(alabel : PChar);
begin
  BTab_SetLabel(CPlusObject, alabel);
end;

function TTab.IsSelected : boolean;
begin
  Result := BTab_IsSelected(CPlusObject);
end;

procedure TTab.Select(owner : TView);
begin
  BTab_Select(CPlusObject, owner.CPlusObject);
end;

procedure TTab.Deselect;
begin
  BTab_Deselect(CPlusObject);
end;

procedure TTab.SetEnabled(aon : boolean);
begin
  BTab_SetEnabled(CPlusObject, aon);
end;

function TTab.IsEnabled : boolean;
begin
  Result := BTab_IsEnabled(CPlusObject);
end;

procedure TTab.MakeFocus(infocus : boolean);
begin
  BTab_MakeFocus(CPlusObject, infocus);
end;

function TTab.IsFocus : boolean;
begin
  Result := BTab_IsFocus(CPlusObject);
end;

procedure TTab.SetView(contents : TView);
begin
  BTab_SetView(CPlusObject, contents.CPlusObject);
end;

function TTab.GetView : TView;
begin
  Result := BTab_View(CPlusObject);
end;

procedure TTab.DrawFocusMark(owner : TView; tabFrame : TRect);
begin
  BTab_DrawFocusMark(CPlusObject, owner.CPlusObject, tabFrame.CPlusObject);
end;

procedure TTab.DrawLabel(owner : TView; tabFrame : TRect);
begin
  BTab_DrawLabel(CPlusObject, owner.CPlusObject, tabFrame.CPlusObject);
end;

procedure TTab.DrawTab(owner : TView; tabFrame : TRect;  position: byte; full : boolean);
begin
  BTab_DrawTab(CPlusObject, owner.CPlusObject, tabFrame.CPlusObject, position, full);
end;


//--------------------TTabView

destructor TTabView.Destroy;
begin
  BTabView_Free(CPlusObject);
  inherited;
end;

constructor TTabView.Create( frame : TRect; name : Pchar; width : Tbutton_width; resizingMode : cardinal; flags : cardinal);
begin
  createPas;
  CPlusObject := BTabView_Create(Self, frame.CPlusObject, name, Integer(width),resizingMode,flags);
end;


constructor TTabView.Create( msg: TMessage);
begin
  createPas;
  CPlusObject := BTabView_Create_1(Self, msg.CPlusObject);
end;

function TTabView.Instantiate( msg : TMessage) : TArchivable;
begin
  Result := BTabView_Instantiate(CPlusObject, msg.CPlusObject);
end;

function TTabView.Archive( msg : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BTabView_Archive(CPlusObject, msg.CPlusObject, deep);
end;

function TTabView.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
 // Result := BTabView_Perform(CPlusObject, d, arg);
end;

procedure TTabView.WindowActivated(state : boolean);
begin
  //BTabView_WindowActivated(CPlusObject, state);
end;

procedure TTabView.AttachedToWindow;
begin
  //BTabView_AttachedToWindow(CPlusObject);
end;

procedure TTabView.AllAttached;
begin
  //BTabView_AllAttached(CPlusObject);
end;

procedure TTabView.AllDetached;
begin
  //BTabView_AllDetached(CPlusObject);
end;

procedure TTabView.DetachedFromWindow;
begin
//  BTabView_DetachedFromWindow(CPlusObject);
end;

procedure TTabView.MessageReceived(msg : TMessage);
begin
 // BTabView_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TTabView.FrameMoved(new_position : TPoint);
begin
  //BTabView_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TTabView.FrameResized(w : double; h : double);
begin
//  BTabView_FrameResized(CPlusObject, w, h);
end;

procedure TTabView.KeyDown(bytes : PChar; n : integer);
begin
 // BTabView_KeyDown(CPlusObject, bytes, n);
end;

procedure TTabView.MouseDown( pt: TPoint);
begin
  //BTabView_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure TTabView.MouseUp( pt: TPoint);
begin
  //BTabView_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TTabView.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  //BTabView_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TTabView.Pulse;
begin
 // BTabView_Pulse(CPlusObject);
end;

procedure TTabView.Select(tabIndex : integer);
begin
  BTabView_Select(CPlusObject, tabIndex);
end;

function TTabView.Selection : integer;
begin
//  Result := BTabView_Selection(CPlusObject);
end;

procedure TTabView.MakeFocus(focusState : boolean);
begin
  BTabView_MakeFocus(CPlusObject, focusState);
end;

procedure TTabView.SetFocusTab(tabIndex : integer; focusState : boolean);
begin
  BTabView_SetFocusTab(CPlusObject, tabIndex, focusState);
end;

function TTabView.FocusTab : integer;
begin
  Result := BTabView_FocusTab(CPlusObject);
end;

procedure TTabView.Draw( rect: TRect);
begin
 // BTabView_Draw(CPlusObject, rect.CPlusObject);
end;

function TTabView.DrawTabs : TRect;
begin
//  Result := BTabView_DrawTabs(CPlusObject);
end;

procedure TTabView.DrawBox(selectedTabFrame : TRect);
begin
  //BTabView_DrawBox(CPlusObject, selectedTabFrame.CPlusObject);
end;

function TTabView.TabFrame(tabIndex : integer) : TRect;
begin
  Result := BTabView_TabFrame(CPlusObject, tabIndex);
end;

procedure TTabView.SetFlags(flags : Cardinal);
begin
  BTabView_SetFlags(CPlusObject, flags);
end;

procedure TTabView.SetResizingMode(mode : Cardinal);
begin
  BTabView_SetResizingMode(CPlusObject, mode);
end;

procedure TTabView.GetPreferredSize(width : double; height : double);
begin
//  BTabView_GetPreferredSize(CPlusObject, width, height);
end;

procedure TTabView.ResizeToPreferred;
begin
 // BTabView_ResizeToPreferred(CPlusObject);
end;

function TTabView.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  //Result := BTabView_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TTabView.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  //Result := BTabView_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TTabView.AddTab(tabContents : TView; tab : TTab);
begin
  BTabView_AddTab(CPlusObject, tabContents.CPlusObject, tab.CPlusObject);
end;

function TTabView.RemoveTab(tabIndex : integer) : TTab;
begin
  Result := BTabView_RemoveTab(CPlusObject, tabIndex);
end;


function TTabView.TabAt(tabIndex : integer) : TTab;
begin
  Result := BTabView_TabAt(CPlusObject, tabIndex);
end;

procedure TTabView.SetTabWidth(s : Tbutton_width);
begin
  BTabView_SetTabWidth(CPlusObject, s);
end;

function TTabView.TabWidth : Tbutton_width;
begin
  Result := BTabView_TabWidth(CPlusObject);
end;

procedure TTabView.SetTabHeight(height : double);
begin
  BTabView_SetTabHeight(CPlusObject, height);
end;

function TTabView.TabHeight : double;
begin
  Result := BTabView_TabHeight(CPlusObject);
end;

function TTabView.ContainerView : TView;
begin
  Result := BTabView_ContainerView(CPlusObject);
end;

function TTabView.CountTabs : integer;
begin
  Result := BTabView_CountTabs(CPlusObject);
end;

function TTabView.ViewForTab(tabIndex : integer) : TView;
begin
  Result := BTabView_ViewForTab(CPlusObject, tabIndex);
end;

// Hook

procedure BTabView_AddTab_hook_func(tabw : TTabView; target : TCPlusObject; tab : TCPlusObject); cdecl;
Var targetv : TView;
	   tabtab : TTab;
begin
	targetv:=TView.Wrap(target);
	tabtab:=TTab.Wrap(tab);
	if Tabw <> nil Then Tabw.AddTab(targetv,tabtab);
	targetv.UnWrap;
	tabtab.UNWrap;
end;

procedure BTabView_Draw_hook_func(tabw : TTabView; updaterect : TCPlusObject);cdecl;
var rect : TRect;
begin
	rect:=TRect.Wrap(updaterect);
	if tabw <> nil then tabw.draw(rect);
	rect.UnWrap;
end;

procedure BTabView_DrawBox_hook_func(tabw : TTabView; updaterect : TCPlusObject);cdecl;
var rect : TRect;
begin
	rect:=TRect.Wrap(updaterect);
	if tabw <> nil then tabw.drawBox(rect);
	rect.UnWrap;
end;

procedure BTabView_DrawTabs_hook_func(tabw : TTabView);cdecl;
begin
	if tabw <> nil then tabw.drawTabs;
end;

procedure BTabView_MakeFocus_hook_func;cdecl;
begin
end;

procedure BTabView_RemoveTab_hook_func;cdecl;
begin
end;

procedure BTabView_Select_hook_func;cdecl;
begin
end;

procedure BTabView_SetFocusTab_hook_func;cdecl;
begin
end;

procedure BTabView_SetTabHeight_hook_func;cdecl;
begin
end;

procedure BTabView_SetTabWidth_hook_func;cdecl;
begin
end;

procedure BTabView_TabAt_hook_func;cdecl;
begin
end;

procedure BTabView_TabFrame_hook_func;cdecl;
begin
end;


initialization

 TabView_AddTab_hook := @BTabView_AddTab_hook_func; 
 TabView_Draw_hook :=@BTabView_Draw_hook_func;
 TabView_DrawBox_hook :=@BTabView_DrawBox_hook_func;
 TabView_DrawTabs_hook :=@BTabView_DrawTabs_hook_func;
 TabView_MakeFocus_hook :=@BTabView_MakeFocus_hook_func;
 TabView_RemoveTab_hook :=@BTabView_RemoveTab_hook_func;
 TabView_Select_hook:=@BTabView_Select_hook_func;
 TabView_SetFocusTab_hook :=@BTabView_SetFocusTab_hook_func;
 TabView_SetTabHeight_hook :=@BTabView_SetTabHeight_hook_func;
 TabView_SetTabWidth_hook :=@BTabView_SetTabWidth_hook_func;
 TabView_TabAt_hook :=@BTabView_TabAt_hook_func;
 TabView_TabFrame_hook :=@BTabView_TabFrame_hook_func;

end.
