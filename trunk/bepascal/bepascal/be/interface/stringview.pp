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
unit stringview;

interface

uses
  beobj, interfacedefs,view,Message, Archivable, SupportDefs, Rect, Handler;

type
   TStringView = class(TView)
  private
  public
    constructor Create(bounds : TRect; name : pchar; texte : pchar; resizeflags, flags : cardinal); virtual;
    destructor Destroy; override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetText(texte : PChar);
    function Text : PChar;
    procedure SetAlignment(flag :  TAlignment);
    function Alignment :  TAlignment;
    procedure AttachedToWindow; override;
    procedure Draw(bounds : TRect); override;
    procedure MessageReceived(msg : TMessage);override;
    procedure MouseDown(pt : TPoint);override;
    procedure MouseUp(pt : TPoint);override;
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
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
//    procedure _ReservedStringView1;
//    procedure _ReservedStringView2;
//    procedure _ReservedStringView3;
//    function operator=( :  TStringView) :  TStringView;
//    procedure char *fText;
//    procedure alignment fAlign;
//    procedure uint32 _reserved[3];
  end;

function BStringView_Create(AObject : TBeObject;bounds : TCPlusObject; name : pchar; texte : pchar; resizeflags, flags : cardinal): TCPlusObject; cdecl; external BePascalLibName name 'BStringView_Create';
procedure BStringView_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_Free';
function BStringView_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BStringView_Instantiate';
function BStringView_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BStringView_Archive';
procedure BStringView_SetText(AObject : TCPlusObject; text : PChar); cdecl; external BePascalLibName name 'BStringView_SetText';
function BStringView_Text(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStringView_Text';
procedure BStringView_SetAlignment(AObject : TCPlusObject; flag :  TAlignment); cdecl; external BePascalLibName name 'BStringView_SetAlignment';
function BStringView_Alignment(AObject : TCPlusObject) :  TAlignment; cdecl; external BePascalLibName name 'BStringView_Alignment';
procedure BStringView_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_AttachedToWindow';
procedure BStringView_Draw(AObject : TCPlusObject; bounds : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_Draw';
procedure BStringView_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_MessageReceived';
procedure BStringView_MouseDown(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_MouseDown';
procedure BStringView_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_MouseUp';
procedure BStringView_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_MouseMoved';
procedure BStringView_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_DetachedFromWindow';
procedure BStringView_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_FrameMoved';
procedure BStringView_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BStringView_FrameResized';
function BStringView_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BStringView_ResolveSpecifier';
procedure BStringView_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_ResizeToPreferred';
procedure BStringView_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BStringView_GetPreferredSize';
procedure BStringView_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BStringView_MakeFocus';
procedure BStringView_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_AllAttached';
procedure BStringView_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_AllDetached';
function BStringView_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BStringView_GetSupportedSuites';
function BStringView_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BStringView_Perform';
//procedure BStringView__ReservedStringView1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView__ReservedStringView1';
//procedure BStringView__ReservedStringView2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView__ReservedStringView2';
//procedure BStringView__ReservedStringView3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView__ReservedStringView3';
//function BStringView_operator=(AObject : TCPlusObject;  :  TStringView) :  TStringView; cdecl; external BePascalLibName name 'BStringView_operator=';
//procedure BStringView_char *fText(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_char *fText';
//procedure BStringView_alignment fAlign(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_alignment fAlign';
//procedure BStringView_uint32 _reserved[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringView_uint32 _reserved[3]';

implementation

constructor  TStringView.Create(bounds : TRect; name : pchar; texte : pchar; resizeflags, flags : cardinal);
begin
  CreatePas;
  CPlusObject := BStringView_Create(Self,bounds.CPlusObject,name,texte,resizeflags, flags);
end;

destructor  TStringView.Destroy;
begin
  BStringView_Free(CPlusObject);
  inherited;
end;

function  TStringView.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BStringView_Instantiate(CPlusObject, data.CPlusObject);
end;

function  TStringView.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BStringView_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure  TStringView.SetText(texte : PChar);
begin
  BStringView_SetText(CPlusObject, texte);
end;

function  TStringView.Text : PChar;
begin
  Result := BStringView_Text(CPlusObject);
end;

procedure  TStringView.SetAlignment(flag :  TAlignment);
begin
  BStringView_SetAlignment(CPlusObject, flag);
end;

function  TStringView.Alignment :  TAlignment;
begin
  Result := BStringView_Alignment(CPlusObject);
end;

procedure  TStringView.AttachedToWindow;
begin
//  BStringView_AttachedToWindow(CPlusObject);
end;

procedure  TStringView.Draw(bounds : TRect);
begin
 // BStringView_Draw(CPlusObject, bounds.CPlusObject);
end;

procedure  TStringView.MessageReceived(msg : TMessage);
begin
  //BStringView_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure  TStringView.MouseDown(pt : TPoint);
begin
  //BStringView_MouseDown(CPlusObject, pt.CPlusObject);
end;

procedure  TStringView.MouseUp(pt : TPoint);
begin
 //BStringView_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure  TStringView.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  //BStringView_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure  TStringView.DetachedFromWindow;
begin
  //BStringView_DetachedFromWindow(CPlusObject);
end;

procedure  TStringView.FrameMoved(new_position : TPoint);
begin
  //BStringView_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure  TStringView.FrameResized(new_width : double; new_height : double);
begin
  //BStringView_FrameResized(CPlusObject, new_width, new_height);
end;

function  TStringView.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
 // Result := BStringView_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure  TStringView.ResizeToPreferred;
begin
  //BStringView_ResizeToPreferred(CPlusObject);
end;

procedure  TStringView.GetPreferredSize(width : double; height : double);
begin
  BStringView_GetPreferredSize(CPlusObject, width, height);
end;

procedure  TStringView.MakeFocus(state : boolean);
begin
  BStringView_MakeFocus(CPlusObject, state);
end;

procedure  TStringView.AllAttached;
begin
  //BStringView_AllAttached(CPlusObject);
end;

procedure  TStringView.AllDetached;
begin
  //BStringView_AllDetached(CPlusObject);
end;

function  TStringView.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BStringView_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function  TStringView.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  //Result := BStringView_Perform(CPlusObject, d, arg);
end;

{procedure  TStringView._ReservedStringView1;
begin
  BStringView__ReservedStringView1(CPlusObject);
end;

procedure  TStringView._ReservedStringView2;
begin
  BStringView__ReservedStringView2(CPlusObject);
end;

procedure  TStringView._ReservedStringView3;
begin
  BStringView__ReservedStringView3(CPlusObject);
end;

function  TStringView.operator=( :  TStringView) :  TStringView;
begin
  Result := BStringView_operator=(CPlusObject, );
end;

procedure  TStringView.char *fText;
begin
  BStringView_char *fText(CPlusObject);
end;

procedure  TStringView.alignment fAlign;
begin
  BStringView_alignment fAlign(CPlusObject);
end;

procedure  TStringView.uint32 _reserved[3];
begin
  BStringView_uint32 _reserved[3](CPlusObject);
end;
}

end.
