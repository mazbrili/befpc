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
unit scrollview;

interface

uses
     beobj, view, message, archivable, SupportDefs, rect, list,
  handler, messenger,interfacedefs,font,graphicdefs,scrollbar;

type
  TScrollView = class(TView)
  private
  public
    constructor Create(name : pchar;
								atarget :TView;
								 resizeMask : longint;
								flags : longint;
								horizontal,
								vertical : boolean;
								aborder :Tborder_style ); virtual;
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure Draw(updateRect : TRect);override;
    procedure AttachedToWindow;override;
    function ScrollBar(flag : TOrientation) :  TScrollBar;
    procedure SetBorder(aborder : Tborder_style);
    function Border : Tborder_style;
    function SetBorderHighlighted(state : boolean) : TStatus_t;
    function IsBorderHighlighted : boolean;
    procedure SetTarget(new_target : TView);
    function Target : TView;
    procedure MessageReceived(msg : TMessage);override;
    procedure MouseDown(pt : TPoint);override;
    procedure WindowActivated(state : boolean);override;
    procedure MouseUp(pt : TPoint);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure DetachedFromWindow;override;
    procedure AllAttached;override;
    procedure AllDetached;override;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    procedure ResizeToPreferred;override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
  end;

function BScrollView_Create(AObject : TBeObject;name : pchar;target :TCPlusObject; resizeMask : longint;	flags : longint;horizontal,vertical : boolean;border :Tborder_style ):TCPlusObject; cdecl; external BePascalLibName name 'BScrollView_Create';
//function BScrollView_Create_1(AObject : TBeObject):TCPlusObject; cdecl; external BePascalLibName name 'BScrollView_Create_1';
procedure BScrollView_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_Free';
function BScrollView_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BScrollView_Instantiate';
function BScrollView_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BScrollView_Archive';
procedure BScrollView_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_Draw';
procedure BScrollView_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_AttachedToWindow';
function BScrollView_ScrollBar(AObject : TCPlusObject; flag : TOrientation) :  TScrollBar; cdecl; external BePascalLibName name 'BScrollView_ScrollBar';
procedure BScrollView_SetBorder(AObject : TCPlusObject; border : Tborder_style); cdecl; external BePascalLibName name 'BScrollView_SetBorder';
function BScrollView_Border(AObject : TCPlusObject) : Tborder_style; cdecl; external BePascalLibName name 'BScrollView_Border';
function BScrollView_SetBorderHighlighted(AObject : TCPlusObject; state : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BScrollView_SetBorderHighlighted';
function BScrollView_IsBorderHighlighted(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BScrollView_IsBorderHighlighted';
procedure BScrollView_SetTarget(AObject : TCPlusObject; new_target : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_SetTarget';
function BScrollView_Target(AObject : TCPlusObject) : TView; cdecl; external BePascalLibName name 'BScrollView_Target';
procedure BScrollView_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_MessageReceived';
procedure BScrollView_MouseDown(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_MouseDown';
procedure BScrollView_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BScrollView_WindowActivated';
procedure BScrollView_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_MouseUp';
procedure BScrollView_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_MouseMoved';
procedure BScrollView_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_DetachedFromWindow';
procedure BScrollView_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_AllAttached';
procedure BScrollView_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_AllDetached';
procedure BScrollView_FrameMoved(AObject : TCPlusObject; new_position : TPoint); cdecl; external BePascalLibName name 'BScrollView_FrameMoved';
procedure BScrollView_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BScrollView_FrameResized';
function BScrollView_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BScrollView_ResolveSpecifier';
procedure BScrollView_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScrollView_ResizeToPreferred';
procedure BScrollView_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BScrollView_GetPreferredSize';
procedure BScrollView_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BScrollView_MakeFocus';
function BScrollView_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BScrollView_GetSupportedSuites';
function BScrollView_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BScrollView_Perform';

implementation

constructor TScrollView.Create(name : pchar;
								atarget :TView;
								 resizeMask : longint;
								flags : longint;
								horizontal,
								vertical : boolean;
								aborder :Tborder_style ); 
begin
  CreatePas;
  CPlusObject := BScrollView_Create(Self,name,atarget.CplusObject,resizeMask,flags,horizontal,vertical,aborder);

end;								



destructor TScrollView.Destroy;
begin
  BScrollView_Free(CPlusObject);
  inherited;
end;

function TScrollView.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BScrollView_Instantiate(CPlusObject, data.CPlusObject);
end;

function TScrollView.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BScrollView_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TScrollView.Draw(updateRect : TRect);
begin
//  BScrollView_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure TScrollView.AttachedToWindow;
begin
  //BScrollView_AttachedToWindow(CPlusObject);
end;

function TScrollView.ScrollBar(flag : TOrientation) :  TScrollBar;
begin
  Result := BScrollView_ScrollBar(CPlusObject, flag);
end;

procedure TScrollView.SetBorder(aborder : Tborder_style);
begin
  BScrollView_SetBorder(CPlusObject, aborder);
end;

function TScrollView.Border : Tborder_style;
begin
  Result := BScrollView_Border(CPlusObject);
end;

function TScrollView.SetBorderHighlighted(state : boolean) : TStatus_t;
begin
  Result := BScrollView_SetBorderHighlighted(CPlusObject, state);
end;

function TScrollView.IsBorderHighlighted : boolean;
begin
  Result := BScrollView_IsBorderHighlighted(CPlusObject);
end;

procedure TScrollView.SetTarget(new_target : TView);
begin
  BScrollView_SetTarget(CPlusObject, new_target.CPlusObject);
end;

function TScrollView.Target : TView;
begin
  Result := BScrollView_Target(CPlusObject);
end;

procedure TScrollView.MessageReceived(msg : TMessage);
begin
 inherited;
  //BScrollView_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TScrollView.MouseDown(pt : TPoint);
begin
//  BScrollView_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure TScrollView.WindowActivated(state : boolean);
begin
  //BScrollView_WindowActivated(CPlusObject, state);
end;

procedure TScrollView.MouseUp(pt : TPoint);
begin
  //BScrollView_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TScrollView.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  //BScrollView_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TScrollView.DetachedFromWindow;
begin
  //BScrollView_DetachedFromWindow(CPlusObject);
end;

procedure TScrollView.AllAttached;
begin
  //BScrollView_AllAttached(CPlusObject);
end;

procedure TScrollView.AllDetached;
begin
  //BScrollView_AllDetached(CPlusObject);
end;

procedure TScrollView.FrameMoved(new_position : TPoint);
begin
//  BScrollView_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TScrollView.FrameResized(new_width : double; new_height : double);
begin
  //BScrollView_FrameResized(CPlusObject, new_width, new_height);
end;

function TScrollView.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BScrollView_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure TScrollView.ResizeToPreferred;
begin
  BScrollView_ResizeToPreferred(CPlusObject);
end;

procedure TScrollView.GetPreferredSize(width : double; height : double);
begin
  BScrollView_GetPreferredSize(CPlusObject, width, height);
end;

procedure TScrollView.MakeFocus(state : boolean);
begin
  BScrollView_MakeFocus(CPlusObject, state);
end;

function TScrollView.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BScrollView_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function TScrollView.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BScrollView_Perform(CPlusObject, d, arg);
end;


end.
