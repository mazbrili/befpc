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
unit menubar;

interface

uses
  beobj, menu, SupportDefs, Message, Rect, archivable, handler;

type
	TMenu_Bar_Border = (B_BORDER_FRAME,
											B_BORDER_CONTENTS,
											B_BORDER_EACH_ITEM);
  TMenuBar = class(TMenu)
  private
  public
    constructor Create(frame : TRect; viewName : PChar; resizingMode : Cardinal; layout : TMenu_Layout; resizeToFit : boolean);  
    constructor Create; override;
    destructor Destroy; override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetBorder(aBorder : TMenu_Bar_Border);
    function Border : TMenu_Bar_Border;
    procedure Draw(updateRect : TRect); override;
    procedure AttachedToWindow; override;
    procedure DetachedFromWindow; override;
    procedure MessageReceived(msg : TMessage); override;
    procedure MouseDown(where : TPoint); override;
    procedure WindowActivated(state : boolean); override;
    procedure MouseUp(where : TPoint); override;
    procedure FrameMoved(new_position : TPoint); override;
    procedure FrameResized(new_width : double; new_height : double); override;
    procedure Show;
    procedure Hide;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; aProperty : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure ResizeToPreferred; override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    procedure AllAttached; override;
    procedure AllDetached; override;
{    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
    procedure _ReservedMenuBar1;
    procedure _ReservedMenuBar2;
    procedure _ReservedMenuBar3;
    procedure _ReservedMenuBar4;
    function operator=( : TMenuBar) : TMenuBar;
    procedure StartMenuBar(menuIndex : integer; sticky : boolean; show_menu : boolean; special_rect : TRect);
    function TrackTask(arg : Pointer) : integer;
    function Track(action : ^integer; startIndex : integer; showMenu : boolean) : TMenuItem;
    procedure StealFocus;
    procedure RestoreFocus;
    procedure InitData(layout : TMenu_Layout);
    procedure menu_bar_border fBorder;
    procedure thread_id fTrackingPID;
    procedure int32 fPrevFocusToken;
    procedure sem_id fMenuSem;
    procedure BRect *fLastBounds;
    procedure uint32 _reserved[2];
    procedure bool fTracking;
}
  end;

function BMenuBar_Create(AObject : TBeObject; frame : TCPlusObject; viewName : PChar; resizingMode : Cardinal; layout : TMenu_Layout; resizeToFit : boolean) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuBar_Create';
function BMenuBar_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuBar_Create';
procedure BMenuBar_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_Free';
function BMenuBar_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BMenuBar_Instantiate';
function BMenuBar_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenuBar_Archive';
procedure BMenuBar_SetBorder(AObject : TCPlusObject; aBorder : TMenu_Bar_Border); cdecl; external BePascalLibName name 'BMenuBar_SetBorder';
function BMenuBar_Border(AObject : TCPlusObject) : TMenu_Bar_Border; cdecl; external BePascalLibName name 'BMenuBar_Border';
procedure BMenuBar_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_Draw';
procedure BMenuBar_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_AttachedToWindow';
procedure BMenuBar_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_DetachedFromWindow';
procedure BMenuBar_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_MessageReceived';
procedure BMenuBar_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_MouseDown';
procedure BMenuBar_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenuBar_WindowActivated';
procedure BMenuBar_MouseUp(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_MouseUp';
procedure BMenuBar_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_FrameMoved';
procedure BMenuBar_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BMenuBar_FrameResized';
procedure BMenuBar_Show(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_Show';
procedure BMenuBar_Hide(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_Hide';
function BMenuBar_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; aProperty : PChar) : THandler; cdecl; external BePascalLibName name 'BMenuBar_ResolveSpecifier';
function BMenuBar_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenuBar_GetSupportedSuites';
procedure BMenuBar_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_ResizeToPreferred';
procedure BMenuBar_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BMenuBar_GetPreferredSize';
procedure BMenuBar_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenuBar_MakeFocus';
procedure BMenuBar_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_AllAttached';
procedure BMenuBar_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_AllDetached';
{function BMenuBar_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BMenuBar_Perform';
procedure BMenuBar__ReservedMenuBar1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar__ReservedMenuBar1';
procedure BMenuBar__ReservedMenuBar2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar__ReservedMenuBar2';
procedure BMenuBar__ReservedMenuBar3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar__ReservedMenuBar3';
procedure BMenuBar__ReservedMenuBar4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar__ReservedMenuBar4';
function BMenuBar_operator=(AObject : TCPlusObject;  : TMenuBar) : TMenuBar; cdecl; external BePascalLibName name 'BMenuBar_operator=';
procedure BMenuBar_StartMenuBar(AObject : TCPlusObject; menuIndex : integer; sticky : boolean; show_menu : boolean; special_rect : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_StartMenuBar';
function BMenuBar_TrackTask(AObject : TCPlusObject; arg : Pointer) : integer; cdecl; external BePascalLibName name 'BMenuBar_TrackTask';
function BMenuBar_Track(AObject : TCPlusObject; action : ^integer; startIndex : integer; showMenu : boolean) : TMenuItem; cdecl; external BePascalLibName name 'BMenuBar_Track';
procedure BMenuBar_StealFocus(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_StealFocus';
procedure BMenuBar_RestoreFocus(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_RestoreFocus';
procedure BMenuBar_InitData(AObject : TCPlusObject; layout : TMenu_Layout); cdecl; external BePascalLibName name 'BMenuBar_InitData';
procedure BMenuBar_menu_bar_border fBorder(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_menu_bar_border fBorder';
procedure BMenuBar_thread_id fTrackingPID(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_thread_id fTrackingPID';
procedure BMenuBar_int32 fPrevFocusToken(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_int32 fPrevFocusToken';
procedure BMenuBar_sem_id fMenuSem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_sem_id fMenuSem';
procedure BMenuBar_BRect *fLastBounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_BRect *fLastBounds';
procedure BMenuBar_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_uint32 _reserved[2]';
procedure BMenuBar_bool fTracking(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuBar_bool fTracking';
}

implementation

constructor TMenuBar.Create(frame : TRect; viewName : PChar; resizingMode : Cardinal; layout : TMenu_Layout; resizeToFit : boolean);
begin
  CPlusObject := BMenuBar_Create(Self, frame.CPlusObject, viewName, resizingMode, layout, resizeToFit);
end;

constructor TMenuBar.Create;
begin
	CreatePas;
  CPlusObject := BMenuBar_Create(Self);
end;

destructor TMenuBar.Destroy;
begin
  BMenuBar_Free(CPlusObject);
end;

function TMenuBar.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BMenuBar_Instantiate(CPlusObject, data.CPlusObject);
end;

function TMenuBar.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BMenuBar_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TMenuBar.SetBorder(aBorder : TMenu_Bar_Border);
begin
  BMenuBar_SetBorder(CPlusObject, aBorder);
end;

function TMenuBar.Border : TMenu_Bar_Border;
begin
  Result := BMenuBar_Border(CPlusObject);
end;

procedure TMenuBar.Draw(updateRect : TRect);
begin
  BMenuBar_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure TMenuBar.AttachedToWindow;
begin
  BMenuBar_AttachedToWindow(CPlusObject);
end;

procedure TMenuBar.DetachedFromWindow;
begin
  BMenuBar_DetachedFromWindow(CPlusObject);
end;

procedure TMenuBar.MessageReceived(msg : TMessage);
begin
  BMenuBar_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TMenuBar.MouseDown(where : TPoint);
begin
  BMenuBar_MouseDown(CPlusObject, where.CPlusObject);
end;

procedure TMenuBar.WindowActivated(state : boolean);
begin
  BMenuBar_WindowActivated(CPlusObject, state);
end;

procedure TMenuBar.MouseUp(where : TPoint);
begin
  BMenuBar_MouseUp(CPlusObject, where.CPlusObject);
end;

procedure TMenuBar.FrameMoved(new_position : TPoint);
begin
  BMenuBar_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TMenuBar.FrameResized(new_width : double; new_height : double);
begin
  BMenuBar_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TMenuBar.Show;
begin
  BMenuBar_Show(CPlusObject);
end;

procedure TMenuBar.Hide;
begin
  BMenuBar_Hide(CPlusObject);
end;

function TMenuBar.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; aProperty : PChar) : THandler;
begin
  Result := BMenuBar_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, aProperty);
end;

function TMenuBar.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BMenuBar_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TMenuBar.ResizeToPreferred;
begin
  BMenuBar_ResizeToPreferred(CPlusObject);
end;

procedure TMenuBar.GetPreferredSize(width : double; height : double);
begin
  BMenuBar_GetPreferredSize(CPlusObject, width, height);
end;

procedure TMenuBar.MakeFocus(state : boolean);
begin
  BMenuBar_MakeFocus(CPlusObject, state);
end;

procedure TMenuBar.AllAttached;
begin
  BMenuBar_AllAttached(CPlusObject);
end;

procedure TMenuBar.AllDetached;
begin
  BMenuBar_AllDetached(CPlusObject);
end;

{function TMenuBar.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BMenuBar_Perform(CPlusObject, d, arg);
end;

procedure TMenuBar._ReservedMenuBar1;
begin
  BMenuBar__ReservedMenuBar1(CPlusObject);
end;

procedure TMenuBar._ReservedMenuBar2;
begin
  BMenuBar__ReservedMenuBar2(CPlusObject);
end;

procedure TMenuBar._ReservedMenuBar3;
begin
  BMenuBar__ReservedMenuBar3(CPlusObject);
end;

procedure TMenuBar._ReservedMenuBar4;
begin
  BMenuBar__ReservedMenuBar4(CPlusObject);
end;

function TMenuBar.operator=( : TMenuBar) : TMenuBar;
begin
  Result := BMenuBar_operator=(CPlusObject, );
end;

procedure TMenuBar.StartMenuBar(menuIndex : integer; sticky : boolean; show_menu : boolean; special_rect : TRect);
begin
  BMenuBar_StartMenuBar(CPlusObject, menuIndex, sticky, show_menu, special_rect.CPlusObject);
end;

function TMenuBar.TrackTask(arg : Pointer) : integer;
begin
  Result := BMenuBar_TrackTask(CPlusObject, arg);
end;

function TMenuBar.Track(action : ^integer; startIndex : integer; showMenu : boolean) : TMenuItem;
begin
  Result := BMenuBar_Track(CPlusObject, action, startIndex, showMenu);
end;

procedure TMenuBar.StealFocus;
begin
  BMenuBar_StealFocus(CPlusObject);
end;

procedure TMenuBar.RestoreFocus;
begin
  BMenuBar_RestoreFocus(CPlusObject);
end;

procedure TMenuBar.InitData(layout : TMenu_Layout);
begin
  BMenuBar_InitData(CPlusObject, layout);
end;

procedure TMenuBar.menu_bar_border fBorder;
begin
  BMenuBar_menu_bar_border fBorder(CPlusObject);
end;

procedure TMenuBar.thread_id fTrackingPID;
begin
  BMenuBar_thread_id fTrackingPID(CPlusObject);
end;

procedure TMenuBar.int32 fPrevFocusToken;
begin
  BMenuBar_int32 fPrevFocusToken(CPlusObject);
end;

procedure TMenuBar.sem_id fMenuSem;
begin
  BMenuBar_sem_id fMenuSem(CPlusObject);
end;

procedure TMenuBar.BRect *fLastBounds;
begin
  BMenuBar_BRect *fLastBounds(CPlusObject);
end;

procedure TMenuBar.uint32 _reserved[2];
begin
  BMenuBar_uint32 _reserved[2](CPlusObject);
end;

procedure TMenuBar.bool fTracking;
begin
  BMenuBar_bool fTracking(CPlusObject);
end;
}

end.
