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
unit box;

interface

uses
  BeObj, Archivable, Control, Handler, Message, Rect, SupportDefs,
  InterfaceDefs, View;

type

  TBox = class(TView)
  private
  public
    constructor Create(Frame : TRect; Name : PChar; ResizingMode,
                       Flags : Cardinal; BorderStyle : Tborder_style);
    constructor Create(data : TMessage);
    destructor Destroy; override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetBorder(style : Tborder_style);
    function Border : Tborder_style;
    procedure SetLabel(aLabel : PChar);
    function SetLabel(view_label : TView) : TStatus_t;
    // Conflicting Name: Label is a reserved word in Pascal.
    // I will use: GetLabel
    function GetLabel : PChar;

    function LabelView : TView;
    procedure Draw(bounds : TRect); override;
    procedure AttachedToWindow; override;
    procedure DetachedFromWindow; override;
    procedure AllAttached; override;
    procedure AllDetached; override;
    procedure FrameResized(new_width : double; new_height : double); override;
    procedure MessageReceived(msg : TMessage); override;
    procedure MouseDown(pt : TPoint); override;
    procedure MouseUp(pt : TPoint); override;
    procedure WindowActivated(state : boolean); override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage); override;
    procedure FrameMoved(new_position : TPoint); override;
    function ResolveSpecifier(msg : TMessage; index : integer;
                              specifier : TMessage; form : integer;
                              properti : PChar) : THandler;
    procedure ResizeToPreferred; override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
//    procedure _ReservedBox1;
//    procedure _ReservedBox2;
//    function operator=( : TBox) :  TBox;
//    procedure InitObject(data : TMessage);
//    procedure DrawPlain;
//    procedure DrawFancy;
//    procedure ClearAnyLabel;
//    procedure char *fLabel;
//    procedure BRect fBounds;
//    procedure border_style fStyle;
//    procedure BView *fLabelView;
//    procedure uint32 _reserved[1];
  end;

function BBox_Create(AObject : TBeObject;
                     Frame : TCPlusObject;
                     Name : PChar;
                     ResizingMode, Flags : Cardinal;
                     BorderStyle : Tborder_style) : TCPlusObject;
                     cdecl; external BePascalLibName name 'BBox_Create';

function BBox_Create_1(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BBox_Create_1';
procedure BBox_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_Free';
function BBox_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BBox_Instantiate';
function BBox_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BBox_Archive';
procedure BBox_SetBorder(AObject : TCPlusObject; style :  Tborder_style); cdecl; external BePascalLibName name 'BBox_SetBorder';
function BBox_Border(AObject : TCPlusObject) :  Tborder_style; cdecl; external BePascalLibName name 'BBox_Border';

// Conflicting name Label --> aLabel.
procedure BBox_SetLabel(AObject : TCPlusObject; aLabel : PChar); cdecl; external BePascalLibName name 'BBox_SetLabel';

function BBox_SetLabel(AObject : TCPlusObject; view_label : TView) : TStatus_t; cdecl; external BePascalLibName name 'BBox_SetLabel';
function BBox_Label(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BBox_Label';

function BBox_LabelView(AObject : TCPlusObject) : TView; cdecl; external BePascalLibName name 'BBox_LabelView_1';

procedure BBox_Draw(AObject : TCPlusObject; bounds : TRect); cdecl; external BePascalLibName name 'BBox_Draw';
procedure BBox_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_AttachedToWindow';
procedure BBox_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_DetachedFromWindow';
procedure BBox_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_AllAttached';
procedure BBox_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_AllDetached';
procedure BBox_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BBox_FrameResized';
procedure BBox_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BBox_MessageReceived';
procedure BBox_MouseDown(AObject : TCPlusObject; pt : TPoint); cdecl; external BePascalLibName name 'BBox_MouseDown';
procedure BBox_MouseUp(AObject : TCPlusObject; pt : TPoint); cdecl; external BePascalLibName name 'BBox_MouseUp';
procedure BBox_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BBox_WindowActivated';
procedure BBox_MouseMoved(AObject : TCPlusObject; pt : TPoint; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BBox_MouseMoved';
procedure BBox_FrameMoved(AObject : TCPlusObject; new_position : TPoint); cdecl; external BePascalLibName name 'BBox_FrameMoved';
function BBox_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BBox_ResolveSpecifier';
procedure BBox_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_ResizeToPreferred';
procedure BBox_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BBox_GetPreferredSize';
procedure BBox_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BBox_MakeFocus';
function BBox_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BBox_GetSupportedSuites';
function BBox_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BBox_Perform';
{
procedure BBox__ReservedBox1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox__ReservedBox1';
procedure BBox__ReservedBox2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox__ReservedBox2';
function BBox_operator=(AObject : TCPlusObject;  :  TBox) :  TBox; cdecl; external BePascalLibName name 'BBox_operator=';
procedure BBox_InitObject(AObject : TCPlusObject; data : TMessage); cdecl; external BePascalLibName name 'BBox_InitObject';
procedure BBox_DrawPlain(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_DrawPlain';
procedure BBox_DrawFancy(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_DrawFancy';
procedure BBox_ClearAnyLabel(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_ClearAnyLabel';
procedure BBox_char *fLabel(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_char *fLabel';

procedure BBox_BRect fBounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_BRect fBounds';

procedure BBox_border_style fStyle(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_border_style fStyle';
procedure BBox_BView *fLabelView(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_BView *fLabelView';
procedure BBox_uint32 _reserved[1](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBox_uint32 _reserved[1]';
}

implementation


constructor TBox.Create(Frame : TRect; Name : PChar; ResizingMode, Flags : Cardinal; BorderStyle : Tborder_style);
begin
  CreatePas;
  CPlusObject := BBox_Create(Self, Frame.CPlusObject, Name, ResizingMode, Flags, BorderStyle);
end;

constructor TBox.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BBox_Create_1(Self, data.CPlusObject);
end;

destructor TBox.Destroy;
begin
  BBox_Free(CPlusObject);
  inherited;
end;

function TBox.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BBox_Instantiate(CPlusObject, data.CPlusObject);
end;

function TBox.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BBox_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TBox.SetBorder(style : Tborder_style);
begin
  BBox_SetBorder(CPlusObject, style);
end;

function TBox.Border : Tborder_style;
begin
  Result := BBox_Border(CPlusObject);
end;

procedure TBox.SetLabel(aLabel : PChar);
begin
  BBox_SetLabel(CPlusObject, aLabel);
end;

function TBox.SetLabel(view_label : TView) : TStatus_t;
begin
  Result := BBox_SetLabel(CPlusObject, view_label{.CPlusObject});
end;

// Conflicting Name: Label is a reserved word in Pascal.
// I will use: GetLabel
function TBox.GetLabel : PChar;
begin
  Result := BBox_Label(CPlusObject);
end;


function TBox.LabelView : TView;
begin
  Result := BBox_LabelView(CPlusObject);
end;


procedure TBox.Draw(bounds : TRect);
begin
  BBox_Draw(CPlusObject, bounds{.CPlusObject});
end;

procedure TBox.AttachedToWindow;
begin
  BBox_AttachedToWindow(CPlusObject);
end;

procedure TBox.DetachedFromWindow;
begin
  BBox_DetachedFromWindow(CPlusObject);
end;

procedure TBox.AllAttached;
begin
  BBox_AllAttached(CPlusObject);
end;

procedure TBox.AllDetached;
begin
  BBox_AllDetached(CPlusObject);
end;

procedure TBox.FrameResized(new_width : double; new_height : double);
begin
  BBox_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TBox.MessageReceived(msg : TMessage);
begin
  BBox_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TBox.MouseDown(pt : TPoint);
begin
  BBox_MouseDown(CPlusObject, pt{.CPlusObject});
end;

procedure TBox.MouseUp(pt : TPoint);
begin
  BBox_MouseUp(CPlusObject, pt{.CPlusObject});
end;

procedure TBox.WindowActivated(state : boolean);
begin
  BBox_WindowActivated(CPlusObject, state);
end;

procedure TBox.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  BBox_MouseMoved(CPlusObject, pt{.CPlusObject}, code, msg);
end;

procedure TBox.FrameMoved(new_position : TPoint);
begin
  BBox_FrameMoved(CPlusObject, new_position{.CPlusObject});
end;

function TBox.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BBox_ResolveSpecifier(CPlusObject, msg{.CPlusObject}, index, specifier{.CPlusObject}, form, properti);
end;

procedure TBox.ResizeToPreferred;
begin
  BBox_ResizeToPreferred(CPlusObject);
end;

procedure TBox.GetPreferredSize(width : double; height : double);
begin
  BBox_GetPreferredSize(CPlusObject, width, height);
end;

procedure TBox.MakeFocus(state : boolean);
begin
  BBox_MakeFocus(CPlusObject, state);
end;

function TBox.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BBox_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function TBox.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BBox_Perform(CPlusObject, d, arg);
end;

{
procedure TBox._ReservedBox1;
begin
  BBox__ReservedBox1(CPlusObject);
end;

procedure TBox._ReservedBox2;
begin
  BBox__ReservedBox2(CPlusObject);
end;

function TBox.operator=( :  TBox) :  TBox;
begin
  Result := BBox_operator=(CPlusObject, );
end;
}

{
procedure TBox.InitObject(data : TMessage);
begin
  BBox_InitObject(CPlusObject, data.CPlusObject);
end;

procedure TBox.DrawPlain;
begin
  BBox_DrawPlain(CPlusObject);
end;

procedure TBox.DrawFancy;
begin
  BBox_DrawFancy(CPlusObject);
end;

procedure TBox.ClearAnyLabel;
begin
  BBox_ClearAnyLabel(CPlusObject);
end;
}

{
procedure TBox.char *fLabel;
begin
  BBox_char *fLabel(CPlusObject);
end;

procedure TBox.BRect fBounds;
begin
  BBox_BRect fBounds(CPlusObject);
end;

procedure TBox.border_style fStyle;
begin
  BBox_border_style fStyle(CPlusObject);
end;

procedure TBox.BView *fLabelView;
begin
  BBox_BView *fLabelView(CPlusObject);
end;

procedure TBox.uint32 _reserved[1];
begin
  BBox_uint32 _reserved[1](CPlusObject);
end;
}

end.